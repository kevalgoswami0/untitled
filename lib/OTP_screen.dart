import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPVerifyPage extends StatefulWidget {
  final String phone;

  const OTPVerifyPage({super.key, required this.phone});

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  final otpController = TextEditingController();
  bool isVerifying = false;

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid OTP")),
      );
      return;
    }

    setState(() => isVerifying = true);

    final response = await http.post(
      Uri.parse("https://phone-auth-api.glitch.me/verify_otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": widget.phone, "otp": otp}),
    );

    final res = jsonDecode(response.body);
    setState(() => isVerifying = false);

    if (res["verified"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("OTP sent to: ${widget.phone}"),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter OTP"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isVerifying ? null : verifyOtp,
              child: isVerifying
                  ? const CircularProgressIndicator()
                  : const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
