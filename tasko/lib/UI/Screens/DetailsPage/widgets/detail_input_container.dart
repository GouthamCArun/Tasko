import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Components/DetailsScreen/date_birth.dart';
import 'package:tasko/UI/Components/DetailsScreen/email_screen.dart';

import '../../../Components/DetailsScreen/gender_screen.dart';
import '../../../Components/DetailsScreen/name_screen.dart';
import '../../../Components/DetailsScreen/wh_screen.dart';
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
          GenderScreen(
            previousPage: () {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
            nextPage: () {
              _pageController.animateToPage(
                3,
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
          WhScreen(
            previousPage: () {
              _pageController.animateToPage(
                3,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
            nextPage: () {
              _pageController.animateToPage(
                5,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
          )
        ],
      ),
    );
  }
}
