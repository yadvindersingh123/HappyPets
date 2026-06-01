
import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:flutter/material.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp1> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(screenSize.width * 0.12),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/HAPPYPETS.jpg',
                    width: screenSize.width * 0.3,
                    height: screenSize.width * 0.3,
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  _buildTextField(
                    keyboardType: TextInputType.name,
                    label: 'Full Name',
                    hint: 'Enter Full Name',
                    icon: Icons.person,
                    screenSize: screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  _buildTextField(
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email',
                    hint: 'Enter Email',
                    icon: Icons.email,
                    screenSize: screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  _buildTextField(
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    hint: 'Enter Password',
                    icon: Icons.password,
                    screenSize: screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Addpet3()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blue.shade50,
                      minimumSize: Size(double.infinity, screenSize.height * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.015,
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: screenSize.width * 0.04),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextInputType keyboardType,
    required String label,
    required String hint,
    required IconData icon,
    required Size screenSize,
  }) {
    return TextField(
      keyboardType: keyboardType,
      style: TextStyle(fontSize: screenSize.width * 0.04),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: screenSize.width * 0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenSize.width * 0.02),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.04,
          vertical: screenSize.height * 0.02,
        ),
      ),
    );
  }
}
