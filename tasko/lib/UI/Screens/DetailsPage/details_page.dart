import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/detail_input_container.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 239, 240, 1),
      body: Stack(
        children: [
          Container(
            height: 560.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/Detailspage/backimage.png'),
            )),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: DetailInputContainer(),
          ),
        ],
      ),
    );
  }
}
