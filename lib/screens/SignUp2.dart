import 'package:HAPPYPETS/screens/otp.dart';
import 'package:flutter/material.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp2> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: screenSize.height * 0.04),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/HAPPYPETS.jpg',
                  height: screenSize.width * 0.4,
                  width: screenSize.width * 0.4,
                ),
                Container(
                  height: screenSize.height * 0.5,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(screenSize.width * 0.03),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenSize.width * 0.08,
                      right: screenSize.width * 0.08,
                      top: screenSize.height * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign Up With Phone',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.055,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        _buildTextField(
                          keyboardType: TextInputType.emailAddress,
                          label: 'Name',
                          hint: 'Enter Full Name',
                          icon: Icons.email,
                          screenSize: screenSize,
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        _buildTextField(
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          hint: 'Enter Phone Number',
                          icon: Icons.phone,
                          screenSize: screenSize,
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OtpScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black54,
                            backgroundColor: Colors.white,
                            minimumSize: Size(double.infinity, screenSize.height * 0.06),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.015,
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: screenSize.width * 0.04),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                  child: Text(
                    "By clicking start you agree to our Terms and Conditions.",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenSize.width * 0.035,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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
