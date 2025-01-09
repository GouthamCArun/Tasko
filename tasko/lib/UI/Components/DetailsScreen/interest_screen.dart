import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:tasko/UI/Components/DetailsScreen/location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Themes/colors.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> interests = [
    'Badminton',
    'Skating',
    'Football',
    'Swimming',
  ];

  List<String> selectedInterests = [];
  String _userName = 'Buddy';
  @override
  void initState() {
    getName();
    super.initState();
  }

  getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('Name') ?? 'Buddy';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  '${_userName.substring(0, 1).toUpperCase() + _userName.substring(1)}, Select your interest',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 9.h),
                Text(
                  'Tell us what you’re interested in so we can customise the app for your needs.',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: pblack,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: interests.map((interest) {
                    return GridItem(
                      key: Key(interest),
                      name: interest,
                      url:
                          'assets/Detailspage/interest-${interest.toLowerCase()}.png',
                      isSelected: selectedInterests.contains(interest),
                      onTap: () {
                        setState(() {
                          if (selectedInterests.contains(interest)) {
                            selectedInterests.remove(interest);
                          } else {
                            selectedInterests.add(interest);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedInterests.contains('yoga')) {
                          selectedInterests.remove('yoga');
                        } else {
                          selectedInterests.add('yoga');
                        }
                      });
                    },
                    child: Container(
                      height: 154.h,
                      width: 156.w,
                      decoration: BoxDecoration(
                        color: lightred3,
                        border: Border.all(
                          color: selectedInterests.contains('yoga')
                              ? Colors.red
                              : const Color.fromRGBO(255, 199, 199, 1),
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/Detailspage/interest-yoga.png',
                              height: 120.h, width: 120.w),
                          Text('Yoga',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: black800,
                                fontSize: 18.sp,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: selectedInterests.isEmpty ? red2 : red1,
                  minimumSize: Size(327.w, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                onPressed: () async {
                  print(selectedInterests);
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setStringList('interests', selectedInterests);
                  if (selectedInterests.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "please select an interest",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const LocationScreen()),
                      ),
                    );
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String url;
  final bool isSelected;
  final VoidCallback onTap;
  final String name;
  const GridItem({
    super.key,
    required this.url,
    required this.isSelected,
    required this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: lightred3,
          border: Border.all(
            color: isSelected
                ? Colors.red
                : const Color.fromRGBO(255, 199, 199, 1),
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Image.asset(url, height: 120.h, width: 120.w),
            Text(
              name,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: black800,
                fontSize: 18.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
