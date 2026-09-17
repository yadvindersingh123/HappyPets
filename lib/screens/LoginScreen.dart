import 'dart:async';

import 'package:HAPPYPETS/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  static const _countryCodes = {
    'India': '+91',
    'United States / Canada': '+1',
    'United Kingdom': '+44',
    'Australia': '+61',
    'United Arab Emirates': '+971',
    'Singapore': '+65',
    'Nepal': '+977',
    'Sri Lanka': '+94',
    'Bangladesh': '+880',
    'Pakistan': '+92',
    'Germany': '+49',
    'France': '+33',
    'Japan': '+81',
    'China': '+86',
    'South Africa': '+27',
  };
  String _country = 'India';
  bool _loading = false;
  Timer? _continueTimer;

  void _login() {
    if (_loading || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final phoneNumber =
        '${_countryCodes[_country]} ${_phoneController.text.trim()}';
    setState(() => _loading = true);
    _continueTimer = Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _loading = false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(phoneNumber: phoneNumber),
        ),
      );
    });
  }

  @override
  void dispose() {
    _continueTimer?.cancel();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/HAPPYPETS.jpg', height: 160),
                    const SizedBox(height: 32),
                    const Text(
                      'Sign in with phone number',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Enter your phone number to continue to HappyPets.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Country code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _country,
                          isExpanded: true,
                          isDense: true,
                          items: _countryCodes.entries.map((country) {
                            return DropdownMenuItem(
                              value: country.key,
                              child: Text('${country.key} (${country.value})'),
                            );
                          }).toList(),
                          onChanged: _loading
                              ? null
                              : (country) {
                                  if (country != null) {
                                    setState(() => _country = country);
                                    if (_phoneController.text.isNotEmpty) {
                                      _formKey.currentState!.validate();
                                    }
                                  }
                                },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      enabled: !_loading,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [
                        AutofillHints.telephoneNumberNational
                      ],
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        hintText: 'Enter phone number',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        final phone =
                            (value ?? '').replaceAll(RegExp(r'[ ()-]'), '');
                        if (phone.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (_country == 'India' && phone.length != 10) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        if (phone.length < 6 ||
                            phone.length + _countryCodes[_country]!.length - 1 >
                                15) {
                          return 'Enter a valid phone number for this country code';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _login(),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _loading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.blue.shade50,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
