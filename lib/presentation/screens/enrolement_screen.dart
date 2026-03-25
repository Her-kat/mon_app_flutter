import 'package:flutter/material.dart';
import '../../models/locataire_model.dart';
import '../../services/locataire_service.dart';
import '../../services/session_service.dart';

class EnrolementScreen extends StatefulWidget {
  const EnrolementScreen({super.key});

  @override
  State<EnrolementScreen> createState() => _EnrolementScreenState();
}

class _EnrolementScreenState extends State<EnrolementScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _quartierCtrl = TextEditingController();

  bool _isLoading = false;

  void _valider() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final locataire = LocataireModel(
        id: '',
        nom: _nomCtrl.text,
        postNom: '',
        prenom: '',
        telephone: _telCtrl.text,
        dateEntree: DateTime.now(),

        nbGarcons: 0,
        nbFilles: 0,

        commune: '',
        quartier: _quartierCtrl.text,
        chefQuartier: '',
        numNyumbaKumi: '',

        estPremiereLocation: true,
        ancienBailleurNom: null,
        ancienBailleurTels: null,
        provenanceChefQuartier: null,
        provenanceChefAvenue: null,
        provenanceNyumbaKumi: null,
      );

      await LocataireService().ajouterLocataire(locataire);

      await SessionService.enregistrerSession(_telCtrl.text);

      if (!mounted) return;

      setState(() => _isLoading = false);

      Navigator.pushReplacementNamed(context, '/dashboard_tenant');
    }
  }

  @override
  void dispose() {
    _nomCtrl.dispose();
    _telCtrl.dispose();
    _quartierCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enrôlement"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // NOM
              TextFormField(
                controller: _nomCtrl,
                decoration: const InputDecoration(
                  labelText: "Nom complet",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Entrez votre nom" : null,
              ),

              const SizedBox(height: 15),

              // TELEPHONE
              TextFormField(
                controller: _telCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.length < 9
                        ? "Numéro invalide"
                        : null,
              ),

              const SizedBox(height: 15),

              // QUARTIER
              TextFormField(
                controller: _quartierCtrl,
                decoration: const InputDecoration(
                  labelText: "Quartier",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty
                        ? "Champ obligatoire"
                        : null,
              ),

              const SizedBox(height: 25),

              // BOUTON
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _valider,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Enregistrer"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
