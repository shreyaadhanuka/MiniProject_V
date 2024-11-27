import 'package:flutter/material.dart';

class NGOProfilePage extends StatelessWidget {
  final String ngoName = 'Helping Hands';
  final String uniqueID = 'NGO123456';
  final String location = 'Nagpur, Maharashtra';
  final String email = 'helpinghands@example.com';
  final String phoneNumber = '123-456-7890';
  final String ngoType = 'Children Above 8 Years';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Profile'),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.green[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NGO Profile Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            _buildProfileItem('NGO Name:', ngoName),
            _buildProfileItem('Unique ID:', uniqueID),
            _buildProfileItem('Location:', location),
            _buildProfileItem('Email:', email),
            _buildProfileItem('Phone Number:', phoneNumber),
            _buildProfileItem('NGO Type:', ngoType),
            SizedBox(height: 20),
            Center(
              // child: ElevatedButton(
              //   onPressed: () {
              //     // Logic to edit profile or go back
              //     Navigator.pop(context);
              //   },
              //   style: ElevatedButton.styleFrom(
              //      backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              //   ),
              //   child: Text(
              //     'Edit Profile',
              //     style: TextStyle(
              //       color: Colors.green[800],
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
