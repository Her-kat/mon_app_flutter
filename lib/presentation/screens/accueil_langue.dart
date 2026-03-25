import 'package:flutter/material.dart';

class AccueilLangueScreen extends StatelessWidget {
  const AccueilLangueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF0D47A1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBtn(context, "Français", "🇫🇷"),
            _buildBtn(context, "English", "🇬🇧"),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context, String label, String flag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: Text("$flag $label"),
      ),
    );
  }
}
