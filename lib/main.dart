import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/ngo_dashboard.dart';
import 'screens/volunteer_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalNGO Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/ngoDashboard': (context) => NGODashboard(),
        '/volunteerDashboard': (context) => VolunteerDashboard(),
      },
    );
  }
}

