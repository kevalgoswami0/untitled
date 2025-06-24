// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'OTP_screen.dart';
//
//
// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//
//   Future<void> registerUser() async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passController.text.trim(),
//       );
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomePage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = 'Signup failed';
//       if (e.code == 'email-already-in-use') message = 'Email already in use';
//       if (e.code == 'weak-password') message = 'Weak password';
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: passController,
//               decoration: const InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: registerUser,
//               child: const Text("Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
