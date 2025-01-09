import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasko/UI/Themes/colors.dart';
import 'package:tasko/UI/Themes/styles.dart';
import 'package:readmore/readmore.dart';

import '../../Screens/PaymentScreen/payment_screen.dart';

class JoinCourse extends StatefulWidget {
  final int courseId;
  final Map<String, dynamic> courseInfo; // Add this line to accept courseInfo

  const JoinCourse(
      {super.key, required this.courseId, required this.courseInfo});
  @override
  State<JoinCourse> createState() => _JoinCourseState();
}

class _JoinCourseState extends State<JoinCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 614.h,
          width: 339.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: red1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 18.w, right: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/Joincourse/arrow-left.png',
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      widget.courseInfo['Learning'],
                      style: joinCourse1,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      widget.courseInfo['CourseName'],
                      style: joinCourse2,
                    ),
                    Text(
                      "with ${widget.courseInfo['TrainerName']}",
                      style: joinCourse3,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: <Widget>[
                            for (var tag in [
                              widget.courseInfo['Duration'],
                              widget.courseInfo['Location']
                            ])
                              Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/Joincourse/hourglass.png',
                                    width: 25.w,
                                    height: 25.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    tag,
                                    style: joinCourse3,
                                  ),
                                ],
                              )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'Overview',
                        style: joinCourse2,
                      ),
                    ),
                    ReadMoreText(
                      widget.courseInfo['Description'],
                      trimLines: 6,
                      textAlign: TextAlign.left,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'What you\'ll be learning',
                        style: joinCourse2,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: <Widget>[
                            if (widget.courseInfo['CourseOutcome'] != null)
                              for (var tag
                                  in widget.courseInfo['CourseOutcome'])
                                Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/Joincourse/hourglass.png',
                                      width: 25.w,
                                      height: 25.h,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      tag,
                                      style: joinCourse3,
                                    ),
                                  ],
                                )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'What you\'ll need',
                        style: joinCourse2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: <Widget>[
                          if (widget.courseInfo['Prerequisites'] != null)
                            for (var tag in widget.courseInfo['Prerequisites'])
                              Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/Joincourse/hourglass.png',
                                    width: 25.w,
                                    height: 25.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    tag,
                                    style: joinCourse3,
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: red1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    )),
                    minimumSize: Size(339.w, 50.h),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentScreen()));
                  },
                  child: Text(
                    'Join for ₹${widget.courseInfo['Price']}',
                    style: joincourse,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
