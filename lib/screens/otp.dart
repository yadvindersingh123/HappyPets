import 'package:HAPPYPETS/screens/Add%20your%20pet.dart';
import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: screenSize.width * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenSize.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: screenSize.width * 0.05,
                top: screenSize.height * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Verification",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: screenSize.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Enter your OTP code here",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          Form(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => _buildOtpTextField(screenSize),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.2,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addpet3()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue.shade50,
                minimumSize: Size(
                  double.infinity,
                  screenSize.height * 0.07,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                ),
              ),
              child: Text(
                'Verify Now',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: screenSize.width * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpTextField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.15,
      height: screenSize.width * 0.15,
      child: TextFormField(
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        style: TextStyle(
          fontFamily: 'CustomFont',
          color: Colors.black,
          fontSize: screenSize.width * 0.07,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenSize.width * 0.02),
          ),
          contentPadding: EdgeInsets.all(screenSize.width * 0.02),
        ),
      ),
    );
  }
}
