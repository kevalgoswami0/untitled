import 'package:flutter/material.dart';


import 'google_sign_in.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Init Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignInPage(),
    );
    //hai my name is bhavesh
  }
}
///aam joha bol : tuu amm kai pan change kar pasi uperna ola select karje hvve push karvani che shit + ctl + k hu karu em s + c + k ??aakar
