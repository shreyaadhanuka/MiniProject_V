import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _hidePassword = true;
  bool _isLoading = false;

  Future<bool> _isUserAllowed() async {
    try {
      print('Checking database with following details:');
      print('Name: ${_nameController.text.trim()}');
      print('Email: ${_emailController.text.trim()}');
      print('Phone: ${_phoneController.text.trim()}');
      print('Aadhar: ${_aadharController.text.trim()}');

      var querySnapshot = await _firestore
          .collection('allowed_users')
          .where('Aadhar number', isEqualTo: _aadharController.text.trim())
          .get();

      // Print all documents found
      print('\nFetched data from Firestore:');
      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}');
        print('Document Data: ${doc.data()}');
      });

      if (querySnapshot.docs.isEmpty) {
        print('\nNo matching records found');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your details do not match our records')),
        );
        return false;
      }

      print('\nMatching record found!');
      return true;
    } catch (e) {
      print('\nError during database check: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking credentials: $e')),
      );
      return false;
    }
  }

  Future<void> _signUp() async {
    if (!_validateFields()) return;

    setState(() => _isLoading = true);

    try {
      bool isAllowed = await _isUserAllowed();

      if (isAllowed) {
        print('\nSign up successful!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up successful!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print('\nError during sign up: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during sign up: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool _validateFields() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _aadharController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return false;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return false;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(_phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return false;
    }

    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 8 characters long')),
      );
      return false;
    }

    return true;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool isPassword = false,
    List<TextInputFormatter>? formatters,
    String? Function(String?)? validator,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && _hidePassword,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _hidePassword = !_hidePassword),
        )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _aadharController,
                  label: 'Aadhar Number',
                  keyboardType: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  isPassword: true,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[700],
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Sign Up', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}