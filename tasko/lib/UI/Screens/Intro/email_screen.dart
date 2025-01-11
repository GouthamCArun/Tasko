import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/UI/Screens/home/dashboard_screen.dart';

import '../../Themes/colors.dart';
import '../../Themes/styles.dart';

class EmailScreen extends StatefulWidget {
  final Function previousPage;
  final Function nextPage;
  const EmailScreen(
      {super.key, required this.previousPage, required this.nextPage});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, top: 32.h, right: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 2 of 5',
            style: pStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Your Email',
            style: headingStyle,
          ),
          SizedBox(
            height: 25.h,
          ),
          TextField(
            controller: _controller,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                hintText: 'Enter your email',
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
                  print("p");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
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
