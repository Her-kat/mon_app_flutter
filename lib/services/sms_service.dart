import 'package:url_launcher/url_launcher.dart';

class SmsService {
  Future<void> envoyerSMS({
    required String numero,
    required double montant,
    required double mois,
  }) async {
    final message =
        "REÇU : Vous avez payé $mois mois pour $montant\$ à HERITIER KAITEA.";

    final Uri smsUri = Uri(
      scheme: 'sms',
      path: numero,
      queryParameters: {'body': message},
    );

    await launchUrl(smsUri);
  }
}
