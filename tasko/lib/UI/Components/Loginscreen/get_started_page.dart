import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Screens/DetailsPage/details_page.dart';
import 'package:tasko/UI/Themes/colors.dart';
import 'package:tasko/UI/Themes/styles.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: red,
      body: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, top: 100.h, right: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey there,',
                style: startheadstyle,
              ),
              Center(
                child: Image.asset(
                  'assets/Landingpage/getstarted.png',
                ),
              ),
              Center(
                child: SizedBox(
                    width: 212.w,
                    child: Text(
                      'Let’s get started with your tasko journey',
                      style: startpstyle,
                      textAlign: TextAlign.center,
                    )),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: white400,
                  backgroundColor: white100,
                  minimumSize: Size(340.w, 60.h),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const DetailsPage()),
                    ),
                  );
                },
                child: Text(
                  'Continue',
                  style: getbtnstyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
