// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_scheduler/provider/task_provider.dart';
import 'package:task_scheduler/screens/home.dart';
import 'package:provider/provider.dart';
import 'screens/statistics.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> TaskProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts.encodeSans().fontFamily,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home:
        HomeScreen(),
      ),
    );
  }
}

