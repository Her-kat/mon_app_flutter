import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_constants.dart';

class PaymentService {
  
  // 1. CALCULATEUR ANTI-ERREUR (LOGIQUE MÉTIER)
  double calculerTotal(int nombreDeMois) {
    if (nombreDeMois < 1) return 0.0;
    return nombreDeMois * AppConstants.loyerMensuel; // Retourne (X * 25$)
  }

  // 2. LOGIQUE DE PAIEMENT AIRTEL MONEY (+243 970 079 500)
  Future<void> payerViaAirtel(int nbMois) async {
    double montant = calculerTotal(nbMois);
    
    // Syntaxe Airtel RDC : *501*1*1*NUMERO*MONTANT#
    // On encode le '#' pour que le téléphone le reconnaisse
    final String ussdCode = "tel:*501*1*1*${AppConstants.numeroAirtel}*$montant${Uri.encodeComponent('#')}";
    
    await _lancerAppel(ussdCode);
  }

  // 3. LOGIQUE DE PAIEMENT M-PESA (+243 829 266 662)
  Future<void> payerViaMPesa(int nbMois) async {
    double montant = calculerTotal(nbMois);
    
    // Syntaxe M-Pesa RDC : *1122*1*NUMERO*MONTANT#
    final String ussdCode = "tel:*1122*1*${AppConstants.numeroMPesa}*$montant${Uri.encodeComponent('#')}";
    
    await _lancerAppel(ussdCode);
  }

  // 4. FONCTION TECHNIQUE POUR LANCER L'APPEL (MODE USSD)
  Future<void> _lancerAppel(String code) async {
    final Uri url = Uri.parse(code);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Impossible de lancer le code USSD : $code';
    }
  }

  // 5. GÉNÉRATEUR DE REÇU SMS (POUR L'ADMIN)
  String genererTexteRecu(String nomLocataire, int nbMois, double montant) {
    return "REÇU HERKAT RENT : $nomLocataire a payé $nbMois mois ($montant\$). Merci de votre confiance.";
  }
}
