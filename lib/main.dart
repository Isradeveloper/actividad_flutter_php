import 'package:flutter/material.dart';
import 'frmRegistro.dart';
import 'principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Principal(),
        '/frmRegistro': (context) => const frmRegistro(),
      },
    );
  }
}
