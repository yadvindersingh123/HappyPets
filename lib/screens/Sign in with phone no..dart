import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController Phone= TextEditingController();
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.055,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login with your Phone Number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: screenSize.width * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        TextField(
                          controller: Phone,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: screenSize.width * 0.04),
                          decoration: InputDecoration(
                            labelText: 'Enter Phone Number',
                            hintText: '+91**********',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenSize.width * 0.02),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04,
                              vertical: screenSize.height * 0.02,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        ElevatedButton(
                          onPressed: () {
                            SignIn();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black54,
                            backgroundColor: Colors.white,
                            minimumSize: Size(
                              double.infinity,
                              screenSize.height * 0.06,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                            ),
                          ),
                          child: Text(
                            'Start',
                            style: TextStyle(fontSize: screenSize.width * 0.04),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void SignIn()async{
    var url="https://sync.appcodie.com/public/api/register-phone";
    var data={
      "phone_number" : Phone.text,
    };
    var body=json.encode(data);

    var urlParse=Uri.parse(url);
    Response response=await http.post(
      urlParse,
      body: body,
      headers: {
        "Content-Type": "application/json"
      }

    );
    var dataa= jsonDecode(response.body);
    print(dataa);
  }
}
