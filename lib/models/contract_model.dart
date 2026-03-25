class ContractModel {
  final String id;
  final String locataireId;
  final DateTime dateSignature;
  final double montantLoyer;
  final String statut; // 'Actif', 'Terminé', 'En litige'
  
  // Détails spécifiques HERKAT RENT
  final String adresseBien;
  final String nomBailleur;
  final String telephoneBailleur;

  ContractModel({
    required this.id,
    required this.locataireId,
    required this.dateSignature,
    this.montantLoyer = 25.0, // Ton prix fixe
    this.statut = 'Actif',
    required this.adresseBien,
    this.nomBailleur = "HERITIER KAITEA",
    this.telephoneBailleur = "+2439700079500",
  });

  // Pour envoyer vers Firebase
  Map<String, dynamic> toMap() {
    return {
      'locataireId': locataireId,
      'dateSignature': dateSignature.toIso8601String(),
      'montantLoyer': montantLoyer,
      'statut': statut,
      'adresseBien': adresseBien,
      'nomBailleur': nomBailleur,
      'telephoneBailleur': telephoneBailleur,
    };
  }

  // Pour lire depuis Firebase
  factory ContractModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ContractModel(
      id: documentId,
      locataireId: map['locataireId'] ?? '',
      dateSignature: DateTime.parse(map['dateSignature']),
      montantLoyer: map['montantLoyer']?.toDouble() ?? 25.0,
      statut: map['statut'] ?? 'Actif',
      adresseBien: map['adresseBien'] ?? '',
      nomBailleur: map['nomBailleur'] ?? 'HERITIER KAITEA',
      telephoneBailleur: map['telephoneBailleur'] ?? '+2439700079500',
    );
  }
}
