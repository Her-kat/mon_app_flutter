import 'package:flutter/material.dart';
import '../../services/payment_service.dart';
import '../../services/local_storage_service.dart';
import '../../core/constants/app_constants.dart';

class TenantDashboard extends StatefulWidget {
  @override
  _TenantDashboardState createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard> {
  final PaymentService _paymentService = PaymentService();
  int _moisAPayer = 1;
  bool _isPaid = false; // Logique à lier avec ton Firestore (Status)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("HERKAT RENT - Mon Espace"),
        backgroundColor: AppConstants.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. INDICATEUR DE STATUT (VISUEL PRO)
            _buildStatusCard(),

            SizedBox(height: 25),

            // 2. CALCULATEUR DE PAIEMENT
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text("Combien de mois voulez-vous payer ?", style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(icon: Icon(Icons.remove_circle), onPressed: () => setState(() => _moisAPayer > 1 ? _moisAPayer-- : null)),
                        Text("$_moisAPayer", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        IconButton(icon: Icon(Icons.add_circle), onPressed: () => setState(() => _moisAPayer++)),
                      ],
                    ),
                    Text("Total : ${_paymentService.calculerTotal(_moisAPayer)}\$", 
                         style: TextStyle(color: AppConstants.primaryBlue, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            // 3. BOUTONS DE PAIEMENT USSD DIRECT
            _buildPaymentButton("Airtel Money", Colors.red, () => _paymentService.payerViaAirtel(_moisAPayer)),
            SizedBox(height: 10),
            _buildPaymentButton("M-Pesa", Colors.blue, () => _paymentService.payerViaMPesa(_moisAPayer)),

            SizedBox(height: 30),

            // 4. HISTORIQUE OFFLINE (LES 5 DERNIERS REÇUS)
            _buildOfflineHistory(),
          ],
        ),
      ),
    );
  }

  // WIDGET : Carte de Statut (Vert/Rouge)
  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isPaid ? Colors.green : AppConstants.alertRed,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(Icons.home, color: Colors.white, size: 50),
          Text(_isPaid ? "LOYER EN RÈGLE" : "LOYER EN ATTENTE", 
               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          Text("Échéance : le ${AppConstants.loyerMensuel}\$ / mois", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  // WIDGET : Bouton de paiement stylisé
  Widget _buildPaymentButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text("Payer via $label (Sans Internet)", style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  // WIDGET : Historique Offline
  Widget _buildOfflineHistory() {
    return FutureBuilder<List<String>>(
      future: LocalStorageService.chargerRecus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mes 5 derniers reçus (Hors-ligne) :", style: TextStyle(fontWeight: FontWeight.bold)),
            ...snapshot.data!.map((recu) => ListTile(
              leading: Icon(Icons.receipt_long, color: AppConstants.goldAccent),
              title: Text(recu, style: TextStyle(fontSize: 13)),
            )).toList(),
          ],
        );
      },
    );
  }
}
