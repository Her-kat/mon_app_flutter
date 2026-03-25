import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Sauvegarder le dernier reçu localement
  static Future<void> sauvegarderRecu(String recuTexte) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recus = prefs.getStringList('recus_cache') ?? [];
    
    // Garder seulement les 5 derniers
    recus.insert(0, recuTexte);
    if (recus.length > 5) recus.removeLast();
    
    await prefs.setStringList('recus_cache', recus);
  }

  // Récupérer les reçus pour l'affichage Offline
  static Future<List<String>> chargerRecus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recus_cache') ?? ["Aucun reçu enregistré."];
  }
}
