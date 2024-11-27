import 'package:flutter/material.dart';
import 'ngo_form_page.dart';
import 'volunteer_details_page.dart';

class RoleSelectionPage extends StatefulWidget {
  @override
  _RoleSelectionPageState createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String? selectedRole;
  Color ngoButtonColor = Colors.white38;
  Color volunteerButtonColor = Colors.white38;

  void _confirmSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('You selected $selectedRole. Do you want to continue?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (selectedRole == 'NGO') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NGOFormPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VolunteerDetailsPage()),
                  );
                }
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Role'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.green[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedRole = 'NGO';
                      ngoButtonColor = Colors.green[900]!;
                      volunteerButtonColor = Colors.white38;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ngoButtonColor,
                    minimumSize: Size(double.infinity, double.infinity),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Rectangular shape
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20), // Padding inside the button
                  ),
                  child: Text(
                    'NGO',
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedRole = 'Volunteer';
                      volunteerButtonColor = Colors.green[900]!;
                      ngoButtonColor = Colors.white38;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: volunteerButtonColor,
                    minimumSize: Size(double.infinity, double.infinity),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Rectangular shape
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20), // Padding inside the button
                  ),
                  child: Text(
                    'Volunteer',
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _confirmSelection,
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, color: Colors.green[900], fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50), // Full width confirm button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Rectangular confirm button
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
