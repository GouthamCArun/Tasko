import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Themes/colors.dart';

class NameScreen extends StatefulWidget {
  final Function nextPage;
  const NameScreen({super.key, required this.nextPage});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, top: 32.h, right: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 1 of 5',
            style: pStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Your Name',
            style: headingStyle,
          ),
          SizedBox(
            height: 25.h,
          ),
          TextField(
            cursorColor: Colors.grey,
            keyboardType: TextInputType.name,
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Enter your name',
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
            height: 25.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: white400,
              backgroundColor: red,
              minimumSize: Size(340.w, 60.h),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(13),
              )),
            ),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setString('Name', _controller.text);
              widget.nextPage();
            },
            child: Text(
              'Next',
              style: btnstyle,
            ),
          ),
        ],
      ),
    );
  }
}
