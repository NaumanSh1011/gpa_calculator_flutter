import 'package:flutter/material.dart';
import 'package:gpa_calculator/Pages/home.dart';
import 'package:gpa_calculator/Pages/criteria.dart';
import 'package:gpa_calculator/Pages/results.dart';
import 'package:gpa_calculator/Pages/calculator.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Home(),
      '/criteria': (context) => const Criteria(),
      '/calculator': (context) => const Calculator(),
      '/results': (context) => const Results(),
    }
  ));
}
