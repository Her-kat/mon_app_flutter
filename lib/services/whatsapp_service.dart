import 'package:url_launcher/url_launcher.dart';

class WhatsappService {
  // 🔥 TON NUMÉRO ADMIN (fixe)
  static const String adminPhone = "256791819310";

  // 📲 Envoyer message à un numéro (locataire)
  static Future<void> sendMessage(String phone, String message) async {
    final cleanPhone = phone.replaceAll("+", "").replaceAll(" ", "");

    final Uri url = Uri.parse(
      "https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Impossible d'ouvrir WhatsApp";
    }
  }

  // 🔥 Envoyer message directement à TOI (admin)
  static Future<void> sendToAdmin(String message) async {
    final Uri url = Uri.parse(
      "https://wa.me/$adminPhone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Impossible d'ouvrir WhatsApp";
    }
  }
}
