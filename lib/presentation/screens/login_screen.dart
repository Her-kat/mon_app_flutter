import 'package:flutter/material.dart';
import '../../services/session_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion Locataire")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Bienvenue",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Numéro de téléphone",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _identifierLocataire,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Se connecter"),
            ),
          ],
        ),
      ),
    );
  }

  void _identifierLocataire() async {
    if (_phoneController.text.length < 9) return;

    setState(() => _isLoading = true);

    await SessionService.enregistrerSession(_phoneController.text);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/dashboard_tenant');
  }
}
