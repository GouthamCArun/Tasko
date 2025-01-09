import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Themes/colors.dart';
import '../../Themes/styles.dart';
import 'interest_screen.dart';

class WhScreen extends StatefulWidget {
  final Function previousPage;
  final Function nextPage;
  const WhScreen(
      {super.key, required this.previousPage, required this.nextPage});

  @override
  State<WhScreen> createState() => _WhScreenState();
}

class _WhScreenState extends State<WhScreen> {
  final TextEditingController weightcontroller = TextEditingController();
  final TextEditingController heightcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, top: 32.h, right: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 5 of 5',
            style: pStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Your Weight and height',
            style: headingStyle,
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150.w,
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: weightcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'weight in Kg',
                      hintStyle: pStyle,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      )),
                ),
              ),
              SizedBox(
                width: 150.w,
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: heightcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Height in Cm',
                      hintStyle: pStyle,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    widget.previousPage();
                  },
                  child: Text(
                    'Previous',
                    style: headingStyle,
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: white400,
                  backgroundColor: red,
                  minimumSize: Size(121.w, 60.h),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                ),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.setDouble(
                      'weight', double.parse(weightcontroller.text));
                  await prefs.setDouble(
                      'height', double.parse(heightcontroller.text));
                 
                  widget.nextPage();
                // ignore: use_build_context_synchronously
                await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const InterestScreen()),
                    ),
                  );
                },
                child: Text(
                  'Next',
                  style: btnstyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
