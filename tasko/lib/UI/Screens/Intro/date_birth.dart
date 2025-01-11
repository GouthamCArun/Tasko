import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Themes/colors.dart';
import '../../Themes/styles.dart';

class DateOfBirthScreen extends StatefulWidget {
  final Function previousPage;
  final Function nextPage;
  const DateOfBirthScreen(
      {super.key, required this.previousPage, required this.nextPage});

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  final TextEditingController _dateController = TextEditingController();
  late final String formattedDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, top: 32.h, right: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 4 of 5',
            style: pStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Your date of birth',
            style: headingStyle,
          ),
          SizedBox(
            height: 25.h,
          ),
          TextField(
            controller: _dateController,
            cursorColor: Colors.grey,
            readOnly: true,
            decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',
                hintStyle: pStyle,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1930),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: red,
                                  surface: white100,
                                  surfaceTint: white100),
                            ),
                            child: child!);
                      },
                    );
                    formattedDate = DateFormat("dd-MM-yyyy").format(date!);
                    print(formattedDate);
                    setState(() {
                      _dateController.text = formattedDate;
                    });
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
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
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('dob', formattedDate);
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
