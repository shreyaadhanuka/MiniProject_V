import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/screens/volunteer_dashboard.dart';

import 'ngo_dashboard.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      // Add artificial delay to show the splash screen
      await Future.delayed(Duration(seconds: 2));
      User? user = _auth.currentUser;
      if (user != null) {
        // User is logged in, determine their role based on email
        String role = await _getUserRole(user);
        _navigateBasedOnRole(role);
      } else {
        // User is not logged in
        _navigateToLogin();
      }
    } catch (e) {
      print('Error during auth check: $e');
      _navigateToLogin();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _getUserRole(User user) async {
    try {
      // Check if the email belongs to NGO
      if (user.email == 'abc@ngo.in') {
        return 'ngo';
      } else {
        return 'volunteer';
      }
    } catch (e) {
      print('Error determining user role: $e');
      return '';
    }
  }

  void _navigateBasedOnRole(String role) {
    if (role == 'ngo') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NGODashboard()),
      );
    } else if (role == 'volunteer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VolunteerDashboard()),
      );    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green[300]!,
              Colors.green[700]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo here
            Icon(
              Icons.volunteer_activism,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 24),
            Text(
              'LocalNGO Connect',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 48),
            if (_isLoading)
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}