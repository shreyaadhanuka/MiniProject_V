import 'package:flutter/material.dart';

class VolunteerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Volunteer page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
