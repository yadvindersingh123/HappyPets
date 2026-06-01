import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> createAccount() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phoneNumber = phonenumberController.text.trim();
    final String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      _showMessage('Error', 'Please fill all details');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Addpet3()),
    );
  }

  void _showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSignUpForm(context);
  }

  Widget _buildSignUpForm(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/HAPPYPETS.jpg',
                width: screenSize.width * 0.3,
                height: screenSize.width * 0.3,
              ),
              SizedBox(height: screenSize.height * 0.03),
              _buildTextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                label: 'Full Name',
                hint: 'Enter Full Name',
                icon: Icons.person,
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.03),
              _buildTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: 'Email',
                hint: 'Enter Email',
                icon: Icons.email,
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.03),
              _buildTextField(
                controller: phonenumberController,
                keyboardType: TextInputType.phone,
                label: 'Mobile Number',
                hint: '+91**********',
                icon: Icons.phone,
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.03),
              _buildTextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                label: 'Password',
                hint: 'Enter Password',
                icon: Icons.password,
                obscureText: true,
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.04),
              ElevatedButton(
                onPressed: createAccount,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String label,
    required String hint,
    required IconData icon,
    required Size screenSize,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
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