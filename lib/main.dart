import 'package:HAPPYPETS/screens/Add%20to%20Cart.dart';
import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:HAPPYPETS/screens/Dentist.dart';
import 'package:HAPPYPETS/screens/Grooming%202.dart';
import 'package:HAPPYPETS/screens/Grooming.dart';
import 'package:HAPPYPETS/screens/Grppming%201.dart';
import 'package:HAPPYPETS/screens/LoginScreen.dart';
import 'package:HAPPYPETS/screens/Pet%20Store.dart';
import 'package:HAPPYPETS/screens/Sign%20in%20with%20phone%20no..dart';
import 'package:HAPPYPETS/screens/SignUp1.dart';
import 'package:HAPPYPETS/screens/SignUp2.dart';
import 'package:HAPPYPETS/screens/add%20photo.dart';
import 'package:HAPPYPETS/screens/app%20confirmed.dart';
import 'package:HAPPYPETS/screens/appointment.dart';
import 'package:HAPPYPETS/screens/forget%20password%20otp.dart';
import 'package:HAPPYPETS/screens/forget%20password.dart';
import 'package:HAPPYPETS/screens/home.dart';
import 'package:HAPPYPETS/screens/my%20pets.dart';
import 'package:HAPPYPETS/screens/new%20password%20screen.dart';
import 'package:HAPPYPETS/screens/payment.dart';
import 'package:HAPPYPETS/screens/pet%20sitter.dart';
import 'package:HAPPYPETS/screens/sign%20up.dart';
import 'package:HAPPYPETS/screens/sitter%20appointment.dart';
import 'package:HAPPYPETS/screens/social%20meadia.dart';
import 'package:HAPPYPETS/screens/splash.dart';
import 'package:HAPPYPETS/screens/subscription.dart';
import 'package:HAPPYPETS/screens/veterinary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HAPPYPETS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const PetStore(),
    );
  }
}