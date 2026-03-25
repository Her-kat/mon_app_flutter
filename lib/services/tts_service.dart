import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _tts = FlutterTts();

  Future<void> parler(String texte, String langue) async {
    // Configurer la langue selon le choix (fr-FR, sw-TZ, etc.)
    await _tts.setLanguage(langue); 
    await _tts.setPitch(1.0);
    await _tts.speak(texte);
  }

  // Exemple pour ton message de bienvenue
  void bienvenueLingala() {
    parler("Boyei bolamu epai ya mofutisi ndako na bino HERITIER KAITEA...", "fr-FR"); 
    // Note : Si le moteur Lingala n'est pas natif, on utilise souvent le français avec un accent ajusté
  }
}
