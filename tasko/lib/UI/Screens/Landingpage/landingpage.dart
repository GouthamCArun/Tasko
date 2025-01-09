import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/inputcontainer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 239, 240, 1),
      body: Stack(
        children: [
          Container(
            height: 548.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/Landingpage/backimage.png'),
            )),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: InputContainer(),
          ),
        ],
      ),
    );
  }
}
