import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'OTP_screen.dart'; // Make sure OTPVerifyPage is defined in this file

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final phoneController = TextEditingController();
  bool isLoading = false;

  Future<void> sendOtp() async {
    final phone = phoneController.text.trim();

    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid phone number")),
      );
      return;
    }

    setState(() => isLoading = true);
    print("Sending OTP to: $phone");

    try {
      final response = await http.post(
        Uri.parse("https://spark-pretty-spirit.glitch.me"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final res = jsonDecode(response.body);
      setState(() => isLoading = false);

      if (res["success"] == true) {
        print("OTP sent successfully!");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerifyPage(phone: phone),
          ),
        );
      } else {
        print("Failed to send OTP");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send OTP")),
        );
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Auth")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : sendOtp,
              child: isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
