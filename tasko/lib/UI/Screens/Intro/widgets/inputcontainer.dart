import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tasko/UI/Components/Loginscreen/otpauth.dart';

import '../../../Components/Loginscreen/signinpage.dart';
import '../../../Themes/colors.dart';

class InputContainer extends StatefulWidget {
  const InputContainer({
    super.key,
  });

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
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
          SignInPage(
            nextPage: () {
              _pageController.animateToPage(
                2,
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
