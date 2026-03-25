import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_rent/services/session_service.dart';
// Imports des écrans
import 'package:flutter_application_rent/presentation/screens/accueil_langue.dart';
import 'package:flutter_application_rent/presentation/screens/login_screen.dart';
import 'package:flutter_application_rent/presentation/screens/enrolement_screen.dart';
import 'package:flutter_application_rent/presentation/screens/tenant_dashboard.dart';
import 'package:flutter_application_rent/presentation/screens/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? userPhone = await SessionService.recupererSession();
  runApp(HerkatRentApp(initialPhone: userPhone));
}

class HerkatRentApp extends StatelessWidget {
  final String? initialPhone;
  const HerkatRentApp({super.key, this.initialPhone});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HERKAT RENT',
      theme: ThemeData(primaryColor: const Color(0xFF0D47A1), useMaterial3: true),
      initialRoute: initialPhone != null ? '/dashboard_tenant' : '/',
      routes: {
        '/': (context) => const AccueilLangueScreen(),
        '/login': (context) => const LoginScreen(),
        '/enrolement': (context) => const EnrolementScreen(),
        '/dashboard_tenant': (context) => TenantDashboard(),
        '/dashboard_admin': (context) => const AdminDashboard(),
      },
    );
  }
}
