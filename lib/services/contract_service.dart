import '../models/locataire_model.dart';
import '../core/constants/app_constants.dart';
import 'package:intl/intl.dart'; // Pour formater les dates

class ContractService {
  
  // 1. GÉNÉRATEUR DE TEXTE DU CONTRAT (VERSION NUMÉRIQUE)
  String genererTexteContrat(LocataireModel locataire) {
    final String dateJour = DateFormat('dd/MM/yyyy').format(DateTime.now());
    DateFormat('dd/MM/yyyy').format(locataire.dateEntree);

    // Bloc de provenance (Conditionnel)
    String blocProvenance = "";
    if (!locataire.estPremiereLocation) {
      blocProvenance = """
- Provenance : Quartier ${locataire.provenanceChefQuartier}
- Chef d'avenue : ${locataire.provenanceChefAvenue}
- Nyumba Kumi précédent : ${locataire.provenanceNyumbaKumi}
- Ancien Bailleur : ${locataire.ancienBailleurNom} (${locataire.ancienBailleurTels})
""";
    } else {
      blocProvenance = "- Statut : Première location enregistrée.";
    }

    // Le corps du contrat HERKAT RENT
    return """
CONTRAT DE BAIL NUMÉRIQUE – HERKAT RENT
---------------------------------------
Réf : KR-${locataire.id.substring(0, 5).toUpperCase()}
Date de signature : $dateJour

1. LES PARTIES
Bailleur : Monsieur HERITIER KAITEA
Locataire : ${locataire.nom} ${locataire.postNom} ${locataire.prenom}
Tél : ${locataire.telephone}

2. DESCRIPTION DU BIEN & PROVENANCE
Localisation : Commune de ${locataire.commune}, Quartier ${locataire.quartier}
Nyumba Kumi : ${locataire.numNyumbaKumi}
$blocProvenance

3. CONDITIONS FINANCIÈRES
- Loyer mensuel fixe : ${AppConstants.loyerMensuel} \$ (Vingt-cinq Dollars)
- Date d'échéance : Le ${locataire.dateEntree.day} de chaque mois
- Mode de paiement : Application HERKAT RENT (Airtel/M-Pesa)

4. CLAUSES SPÉCIALES
- Le locataire s'engage à payer exclusivement via l'application.
- Tout retard sera signalé aux autorités de base (Chef de Quartier).
- Composition familiale déclarée : ${locataire.nbGarcons} Garçons, ${locataire.nbFilles} Filles.

Signature Numérique : Validée par SIM Binding & OTP.
---------------------------------------
""";
  }

  // 2. FONCTION POUR EXPORT PDF (LOGIQUE À DÉVELOPPER AVEC LE PACKAGE 'PDF')
  void genererPDFContrat(LocataireModel locataire) {
    // Le développeur utilisera ici le texte ci-dessus 
    // pour créer un fichier PDF avec votre logo HERKAT RENT en haut.
    print("Génération du PDF pour ${locataire.nom} en cours...");
  }
}
