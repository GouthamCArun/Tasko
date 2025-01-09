import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Screens/DetailsPage/widgets/toggle_switch.dart';
import '../../Themes/colors.dart';
import '../../Themes/styles.dart';

class GenderScreen extends StatefulWidget {
  final Function previousPage;
  final Function nextPage;
  const GenderScreen(
      {super.key, required this.previousPage, required this.nextPage});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, top: 32.h, right: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 3 of 5',
            style: pStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Your gender',
            style: headingStyle,
          ),
          SizedBox(
            height: 25.h,
          ),
          const Toggle(),
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
                onPressed: () {
                  widget.nextPage();
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
