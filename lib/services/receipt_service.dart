import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class ReceiptService {
  Future<void> generateAndShowReceipt({
    required String nom,
    required String telephone,
    required double montant,
    required double mois,
  }) async {
    final pdf = pw.Document();

    final date = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("REÇU DE PAIEMENT",
                    style: pw.TextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold)),

                pw.SizedBox(height: 20),

                pw.Text("Nom : $nom"),
                pw.Text("Téléphone : $telephone"),

                pw.SizedBox(height: 10),

                pw.Text("Montant payé : $montant FC"),
                pw.Text("Mois payé : $mois"),

                pw.SizedBox(height: 10),

                pw.Text("Date : $date"),

                pw.SizedBox(height: 30),

                pw.Text("Signature: __________________"),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
