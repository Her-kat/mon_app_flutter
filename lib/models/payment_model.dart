import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String tenantId;       // ID du locataire
  final double montant;        // Montant (toujours multiple de 25$)
  final DateTime datePaiement;
  final String periode;        // Ex: "Mars 2024"
  final String operateur;      // "M-Pesa" ou "Airtel"
  final String statut;         // "Validé" ou "En attente"

  PaymentModel({
    required this.id,
    required this.tenantId,
    this.montant = 25.0,
    required this.datePaiement,
    required this.periode,
    required this.operateur,
    this.statut = "Validé",
  });

  // Pour envoyer vers Firebase (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'tenantId': tenantId,
      'montant': montant,
      'datePaiement': Timestamp.fromDate(datePaiement),
      'periode': periode,
      'operateur': operateur,
      'statut': statut,
    };
  }

  // Pour lire depuis Firebase
  factory PaymentModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PaymentModel(
      id: documentId,
      tenantId: map['tenantId'] ?? '',
      montant: (map['montant'] as num?)?.toDouble() ?? 25.0,
      datePaiement: (map['datePaiement'] as Timestamp).toDate(),
      periode: map['periode'] ?? '',
      operateur: map['operateur'] ?? '',
      statut: map['statut'] ?? 'Validé',
    );
  }
}
