import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/locataire_model.dart';

class LocataireService {
  // 1. RÉFÉRENCE À LA COLLECTION SUR FIREBASE
  final CollectionReference _dbUsers = FirebaseFirestore.instance.collection('users');

  // 2. FONCTION POUR ENREGISTRER UN NOUVEAU LOCATAIRE (ULTRA-PRO)
  Future<void> ajouterLocataire(LocataireModel locataire) async {
    try {
      // On utilise .add() pour que Firebase génère un ID unique automatiquement
      await _dbUsers.add(locataire.toMap()).then((value) {
        print("✅ Locataire enregistré avec succès ! ID: ${value.id}");
      });
    } catch (e) {
      print("❌ Erreur lors de l'enregistrement : $e");
      rethrow; // Renvoie l'erreur pour l'afficher sur l'écran (SnackBar)
    }
  }

  // 3. FONCTION POUR RÉCUPÉRER UN LOCATAIRE PAR SON TÉLÉPHONE (LOGIN)
  Future<LocataireModel?> connecterLocataire(String telephone) async {
    try {
      var result = await _dbUsers.where('telephone', isEqualTo: telephone).get();
      
      if (result.docs.isNotEmpty) {
        // On transforme le document Firebase en objet LocataireModel
        return LocataireModel.fromMap(
          result.docs.first.data() as Map<String, dynamic>, 
          result.docs.first.id
        );
      }
      return null; // Aucun locataire trouvé avec ce numéro
    } catch (e) {
      print("❌ Erreur de connexion : $e");
      return null;
    }
  }
}
