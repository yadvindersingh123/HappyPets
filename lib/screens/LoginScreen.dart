import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:HAPPYPETS/screens/SignUp2.dart';
import 'package:HAPPYPETS/screens/sign%20up.dart';
import 'package:flutter/material.dart';
import 'forget password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showErrorDialog('Please enter email and password');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Addpet3(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.08),
              Image.asset(
                'assets/HAPPYPETS.jpg',
                width: screenSize.width * 0.25,
                height: screenSize.width * 0.25,
              ),
              SizedBox(height: screenSize.height * 0.04),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: screenSize.width * 0.04),
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.email, size: screenSize.width * 0.06),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenSize.width * 0.02),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: TextStyle(fontSize: screenSize.width * 0.04),
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  prefixIcon: Icon(Icons.password, size: screenSize.width * 0.06),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenSize.width * 0.02),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const forget()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Forgot Password? ',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.04,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Click',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.red,
                            fontSize: screenSize.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue.shade50,
                  minimumSize: Size(double.infinity, screenSize.height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenSize.width * 0.08),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                  height: screenSize.width * 0.05,
                  width: screenSize.width * 0.05,
                  child: const CircularProgressIndicator(),
                )
                    : Text(
                  'Login',
                  style: TextStyle(fontSize: screenSize.width * 0.04),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(thickness: 1, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.02,
                    ),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(thickness: 1, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.03),
              _buildSignUpButton(
                text: 'Sign UP with Email',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                ),
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.03),
              _buildSignUpButton(
                text: 'Sign UP Phone Number',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp2()),
                ),
                screenSize: screenSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton({
    required String text,
    required VoidCallback onPressed,
    required Size screenSize,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue.shade50,
        minimumSize: Size(double.infinity, screenSize.height * 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenSize.width * 0.04),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: screenSize.width * 0.04),
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Alert();
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white38,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'assets/nerror.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Make sure WiFi or cellular data is turned on and then try again.',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}