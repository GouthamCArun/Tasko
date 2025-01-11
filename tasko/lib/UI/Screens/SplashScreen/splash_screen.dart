import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tasko/UI/Screens/Intro/get_started_page.dart';

import 'package:tasko/UI/Screens/home/dashboard_screen.dart';
import 'package:tasko/UI/Themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  leavePage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLoggedin = prefs.getBool('isLoggedin');
    print(isLoggedin);

    if (isLoggedin == null || isLoggedin == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GetStartedPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStartedPage()),
      );
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      leavePage(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'tasko',
          style: GoogleFonts.inter(
              fontSize: 30, fontWeight: FontWeight.bold, color: red1),
        ),
      ),
    );
  }
}
