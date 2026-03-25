import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/constants/app_constants.dart';
import '../../models/locataire_model.dart';
import '../../services/whatsapp_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String adminEmail = "heritierkaitea632@gmail.com";

  @override
  void initState() {
    super.initState();
    _verifierAcces();
  }

  void _verifierAcces() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email != adminEmail) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Accès refusé : réservé à l’admin"),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PANEL ADMIN - HERKAT"),
        backgroundColor: AppConstants.primaryBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("Aucun locataire trouvé"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final locat =
                  LocataireModel.fromMap(data, docs[index].id);

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading:
                      const CircleAvatar(child: Icon(Icons.person)),

                  title: Text("${locat.nom} ${locat.prenom}"),

                  subtitle: Text(
                      "📞 ${locat.telephone}\n📍 ${locat.quartier}"),

                  trailing: const Icon(
                    Icons.more_vert,
                    color: AppConstants.primaryBlue,
                  ),

                  onTap: () =>
                      _showOptions(locat, docs[index].reference),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // MENU OPTIONS
  void _showOptions(
      LocataireModel locat, DocumentReference ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SUPPRIMER
            ListTile(
              leading:
                  const Icon(Icons.delete, color: Colors.red),
              title: const Text("Supprimer"),
              onTap: () {
                Navigator.pop(context);
                _confirmerSuppression(locat, ref);
              },
            ),

            // WHATSAPP LOCATAIRE
            ListTile(
              leading:
                  const Icon(Icons.message, color: Colors.green),
              title: const Text("Contacter locataire"),
              onTap: () async {
                Navigator.pop(context);

                await WhatsappService.sendMessage(
                  locat.telephone,
                  "Bonjour ${locat.nom}, votre compte HERKAT est actif.",
                );
              },
            ),

            // WHATSAPP ADMIN
            ListTile(
              leading:
                  const Icon(Icons.admin_panel_settings,
                      color: Colors.blue),
              title: const Text("Notifier admin"),
              onTap: () async {
                Navigator.pop(context);

                await WhatsappService.sendToAdmin(
                  "📢 Action sur locataire\n\n"
                  "👤 Nom: ${locat.nom}\n"
                  "📞 Téléphone: ${locat.telephone}\n"
                  "📍 Quartier: ${locat.quartier}",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // CONFIRMATION SUPPRESSION
  void _confirmerSuppression(
      LocataireModel locat, DocumentReference ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmer la suppression"),
        content: Text(
            "Supprimer ${locat.nom} définitivement ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () async {
              await ref.delete();
              Navigator.pop(context);
            },
            child: const Text(
              "Supprimer",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
