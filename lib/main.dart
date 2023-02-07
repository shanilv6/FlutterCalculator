import 'package:flutter/material.dart';

import 'calculator_neuapp.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator Neu-morphism',
      home: CalculatorNeuApp(),
    );
  }
}


