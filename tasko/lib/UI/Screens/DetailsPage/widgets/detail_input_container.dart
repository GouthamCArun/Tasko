import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Screens/Intro/date_birth.dart';
import 'package:tasko/UI/Screens/Intro/email_screen.dart';
import '../../Intro/name_screen.dart';

import '../../../Themes/colors.dart';

class DetailInputContainer extends StatefulWidget {
  const DetailInputContainer({super.key});

  @override
  State<DetailInputContainer> createState() => _DetailInputContainerState();
}

class _DetailInputContainerState extends State<DetailInputContainer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 316.h,
      decoration: const BoxDecoration(
        color: white100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          NameScreen(
            nextPage: () {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
          ),
          EmailScreen(
            previousPage: () {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
            nextPage: () {
              _pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
          ),
          DateOfBirthScreen(
            previousPage: () {
              _pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
            nextPage: () {
              _pageController.animateToPage(
                4,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
          ),
        ],
      ),
    );
  }
}
