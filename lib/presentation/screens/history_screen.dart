import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:intl/intl.dart'; 
// ✅ Utilise le nom de ton projet pour l'import
import 'package:flutter_application_rent/core/constants/app_constants.dart';

class HistoryScreen extends StatelessWidget {
  final String tenantId;
  const HistoryScreen({super.key, required this.tenantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Historique"),
        backgroundColor: AppConstants.primaryBlue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('tenantId', isEqualTo: tenantId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Aucun paiement trouvé"));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text("Loyer : ${doc['montant']}\$"),
                  subtitle: Text("Période : ${doc['periode']}"),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
