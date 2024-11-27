import 'package:flutter/material.dart';

class NGOPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to the NGO page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
