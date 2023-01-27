import 'package:flutter/material.dart';
import 'package:gpa_calculator/Pages/home.dart';
import 'package:gpa_calculator/Pages/semesters.dart';
import 'package:gpa_calculator/Pages/results.dart';
import 'package:gpa_calculator/Pages/calculator.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Home(),
      '/semesters': (context) => const Semesters(),
      '/calculator': (context) => const Results(),
      '/results': (context) => const Calculator(),
      '/criteria': (context) => const Placeholder(),
    }
  ));
}