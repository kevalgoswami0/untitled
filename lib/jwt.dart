import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtExample extends StatelessWidget {
  const JwtExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example JWT (you should get this from your backend after login)
    final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
        "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6..."
        "SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";

    // Decode payload
    final decodedToken = JwtDecoder.decode(token);

    // Check expiry
    final bool isExpired = JwtDecoder.isExpired(token);
    final expiryDate = JwtDecoder.getExpirationDate(token);

    return Scaffold(
      appBar: AppBar(title: const Text("JWT Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Is token expired? $isExpired"),
            Text("Expires at: $expiryDate"),
            const Divider(),
            Text("Decoded Token:\n$decodedToken"),
          ],
        ),
      ),
    );
  }
}
