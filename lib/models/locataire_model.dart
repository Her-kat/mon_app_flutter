class LocataireModel {
  final String id; // ID unique Firebase
  final String nom;
  final String postNom;
  final String prenom;
  final String telephone;
  final DateTime dateEntree;
  
  // Composition Familiale
  final int nbGarcons;
  final int nbFilles;

  // Localisation Actuelle (HERKAT RENT)
  final String commune;
  final String quartier;
  final String chefQuartier;
  final String numNyumbaKumi;

  // LOGIQUE DE PROVENANCE (La partie Ultra-Pro)
  final bool estPremiereLocation;
  final String? ancienBailleurNom;
  final String? ancienBailleurTels;
  final String? provenanceChefQuartier;
  final String? provenanceChefAvenue;
  final String? provenanceNyumbaKumi;

  LocataireModel({
    required this.id,
    required this.nom,
    required this.postNom,
    required this.prenom,
    required this.telephone,
    required this.dateEntree,
    required this.nbGarcons,
    required this.nbFilles,
    required this.commune,
    required this.quartier,
    required this.chefQuartier,
    required this.numNyumbaKumi,
    this.estPremiereLocation = true,
    this.ancienBailleurNom,
    this.ancienBailleurTels,
    this.provenanceChefQuartier,
    this.provenanceChefAvenue,
    this.provenanceNyumbaKumi,
  });

  // Convertir les données de Firebase vers l'application
  factory LocataireModel.fromMap(Map<String, dynamic> map, String documentId) {
    return LocataireModel(
      id: documentId,
      nom: map['nom'] ?? '',
      postNom: map['postNom'] ?? '',
      prenom: map['prenom'] ?? '',
      telephone: map['telephone'] ?? '',
      dateEntree: (map['dateEntree'] as DateTime),
      nbGarcons: map['nbGarcons'] ?? 0,
      nbFilles: map['nbFilles'] ?? 0,
      commune: map['commune'] ?? '',
      quartier: map['quartier'] ?? '',
      chefQuartier: map['chefQuartier'] ?? '',
      numNyumbaKumi: map['numNyumbaKumi'] ?? '',
      estPremiereLocation: map['estPremiereLocation'] ?? true,
      ancienBailleurNom: map['ancienBailleurNom'],
      ancienBailleurTels: map['ancienBailleurTels'],
      provenanceChefQuartier: map['provenanceChefQuartier'],
      provenanceChefAvenue: map['provenanceChefAvenue'],
      provenanceNyumbaKumi: map['provenanceNyumbaKumi'],
    );
  }

  // Convertir l'objet en Map pour l'envoyer vers Firebase
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'postNom': postNom,
      'prenom': prenom,
      'telephone': telephone,
      'dateEntree': dateEntree,
      'nbGarcons': nbGarcons,
      'nbFilles': nbFilles,
      'commune': commune,
      'quartier': quartier,
      'chefQuartier': chefQuartier,
      'numNyumbaKumi': numNyumbaKumi,
      'estPremiereLocation': estPremiereLocation,
      'ancienBailleurNom': ancienBailleurNom,
      'ancienBailleurTels': ancienBailleurTels,
      'provenanceChefQuartier': provenanceChefQuartier,
      'provenanceChefAvenue': provenanceChefAvenue,
      'provenanceNyumbaKumi': provenanceNyumbaKumi,
    };
  }
}
