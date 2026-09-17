import 'dart:async';

import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.phoneNumber = ''});

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Local demo verification; no SMS provider is connected yet.
  static const _demoOtp = '123456';
  final _controller = TextEditingController();
  Timer? _cooldownTimer;
  Timer? _actionTimer;
  int _secondsRemaining = 60;
  bool _verifying = false;
  bool _resending = false;
  String? _error;

  bool get _busy => _verifying || _resending;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    _secondsRemaining = 60;
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        // Timer ticks may be delayed while the app is in the background.
        _secondsRemaining = (60 - timer.tick).clamp(0, 60);
      });
      if (_secondsRemaining == 0) timer.cancel();
    });
  }

  void _verify() {
    if (_busy) return;
    if (_controller.text != _demoOtp) {
      setState(() {
        _error = _controller.text.length != 6
            ? 'Please enter the 6-digit OTP.'
            : 'Incorrect OTP. Please try again.';
      });
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _error = null;
      _verifying = true;
    });
    _actionTimer = Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Addpet3()),
        (_) => false,
      );
    });
  }

  void _resend() {
    if (_busy || _secondsRemaining > 0) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _resending = true;
      _error = null;
    });
    _actionTimer = Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _resending = false;
        _controller.clear();
        _startCooldown();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent.')),
      );
    });
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _actionTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _loader() => const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue.shade50),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.sms_outlined, size: 64, color: Colors.blue),
                  const SizedBox(height: 24),
                  const Text(
                    'Phone Verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.phoneNumber.isEmpty
                        ? 'Enter your 6-digit OTP code.'
                        : 'Enter the 6-digit OTP for ${widget.phoneNumber}.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: _controller,
                    enabled: !_busy,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      labelText: 'OTP code',
                      errorText: _error,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (_) {
                      if (_error != null) setState(() => _error = null);
                    },
                    onSubmitted: (_) => _verify(),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _busy ? null : _verify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      minimumSize: const Size(double.infinity, 52),
                    ),
                    child: _verifying ? _loader() : const Text('Verify OTP'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _busy || _secondsRemaining > 0 ? null : _resend,
                    child: _resending
                        ? _loader()
                        : Text(_secondsRemaining > 0
                            ? 'Resend OTP in ${_secondsRemaining}s'
                            : 'Resend OTP'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
