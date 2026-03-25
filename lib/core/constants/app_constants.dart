import 'package:flutter/material.dart';

class AppConstants {
  // --- IDENTITÉ DU PROJET ---
  static const String appName = "HERKAT RENT";
  static const String slogan = "La gestion immobilière moderne et sécurisée";

  // --- PARAMÈTRES FINANCIERS (FIXES) ---
  static const double loyerMensuel = 25.0; // Prix fixe en dollars
  static const String devise = "USD";

  // --- COORDONNÉES DE RÉCEPTION (OFFICIELLES) ---
  static const String numeroAirtel = "+2439700079500";
  static const String numeroMPesa = "+243829266662";

  // --- SYNTAXE DES CODES USSD (MODE HORS-LIGNE) ---
  // Exemple de formatage automatique pour le développeur
  static String generateAirtelUSSD(int nbMois) {
    double montantTotal = nbMois * loyerMensuel;
    return "*501*1*1*$numeroAirtel*$montantTotal#";
  }

  static String generateMPesaUSSD(int nbMois) {
    double montantTotal = nbMois * loyerMensuel;
    return "*1122*1*$numeroMPesa*$montantTotal#";
  }

  // --- COULEURS DU LOGO (CHARTE GRAPHIQUE) ---
  static const Color primaryBlue = Color(0xFF0D47A1); // Bleu Herkat
  static const Color goldAccent = Color(0xFFD4AF37);  // Or Herkat
  static const Color alertRed = Color(0xFFD32F2F);    // Pour les retards
}
