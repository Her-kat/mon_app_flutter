import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyLoggedPhone = "user_phone";

  // 1. Sauvegarder le numéro après un login ou enrôlement réussi
  static Future<void> enregistrerSession(String telephone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLoggedPhone, telephone);
  }

  // 2. Vérifier si un numéro est déjà enregistré
  static Future<String?> recupererSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLoggedPhone);
  }

  // 3. Déconnexion (si le locataire veut changer de compte)
  static Future<void> fermerSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedPhone);
  }
}
