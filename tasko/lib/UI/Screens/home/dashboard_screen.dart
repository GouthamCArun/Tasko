import 'package:tasko/UI/Screens/home/widgets/completed_task.dart';
import 'package:tasko/UI/Screens/home/widgets/ongiong_task.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/Services/API/fetch_completed_task.dart';
import 'package:tasko/Services/API/fetch_task.dart';
import '../../Themes/colors.dart';
import '../../Themes/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/filter_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController controller = TextEditingController();
  String? searchResult;
  bool isComptaskSelected = true; // Initially, Program is selected
  bool isPageVisible = false; // State for the visibility of sliding page
  String? _user_name;
  String? _location;

  List<Map<String, dynamic>> programs = [];

  void _togglePageVisibility() {
    setState(() {
      isPageVisible = !isPageVisible;
    });
  }

  @override
  void initState() {
    loadContent();
    super.initState();
  }

  loadContent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Daniel',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("notification pressed");
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedin', false);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: ((context) => const LocationScreen()),
                        // ));
                      },
                      child: Image.asset(
                        'assets/Dashboard/notification-icon.png',
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    width: 295.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: lightred,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isComptaskSelected = true;
                            });
                          },
                          child: Container(
                            width: 145.w,
                            height: 37.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                isComptaskSelected
                                    ? const BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: Offset(0, 5),
                                      )
                                    : const BoxShadow(
                                        color: Colors.transparent,
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(0, 0),
                                      ),
                              ],
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: isComptaskSelected
                                    ? lightred2
                                    : Colors.transparent,
                              ),
                              color:
                                  isComptaskSelected ? Colors.white : lightred,
                            ),
                            child: Center(
                              child: Text(
                                'Ongoing🚀',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  color: isComptaskSelected ? red1 : darkgrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isComptaskSelected = false;
                            });
                          },
                          child: Container(
                            width: 145.w,
                            height: 35.04.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                !isComptaskSelected
                                    ? const BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: Offset(0, 5),
                                      )
                                    : const BoxShadow(
                                        color: Colors.transparent,
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(0, 0),
                                      ),
                              ],
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: isComptaskSelected
                                    ? Colors.transparent
                                    : lightred2,
                              ),
                              color:
                                  isComptaskSelected ? lightred : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Wrapped🥳',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  color: isComptaskSelected ? darkgrey : red1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isComptaskSelected ? SizedBox(height: 20.h) : const SizedBox(),
                isComptaskSelected
                    ? Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0.h),
                                    child: TextField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: lightred,
                                        hintText: 'Search Tasks',
                                        hintStyle: locationhintstyle,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: lightred2),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: lightred2),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: lightred2),
                                          borderRadius:
                                              BorderRadius.circular(10.0.r),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.0.h,
                                          horizontal: 16.0.w,
                                        ),
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0.w, right: 8.0.w),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/Dashboard/search-icon.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      style: locationtextstyle,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Filterpage(),
                      ])
                    : const SizedBox(),
                Expanded(
                  child: isComptaskSelected
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: TaskList())
                      : Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CompletedTaskList()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
