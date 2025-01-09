import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/DetailsScreen/location_screen.dart';
import '../../Themes/colors.dart';
import '../../Themes/styles.dart';
import 'package:tasko/UI/Components/CourseScreen/join_course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/filter_page.dart';

class Dashboard extends StatefulWidget {
  final List<String> interestList;

  const Dashboard({required this.interestList});

  @override
  State<StatefulWidget> createState() => _DashboardState();
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
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://render-db-sq2c.onrender.com/user/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          programs = data.cast<Map<String, dynamic>>();
        });
      } else {
        print(
            'Failed to load program data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching program data: $e');
    }
  }

  loadContent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user_name = prefs.getString('Name') ?? 'Buddy';
      _location = prefs.getString('Location') ?? 'Select Location';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 71.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${_user_name!.substring(0, 1).toUpperCase() + _user_name!.substring(1)}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            color: darkgrey,
                            fontSize: 18.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/Dashboard/location-icon.png',
                              width: 32.w,
                              height: 32.h,
                            ),
                            Text(
                              '$_location',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("arrow down pressed");
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("notification pressed");
                        // Add your onPressed action here
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedin', false);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const LocationScreen()),
                        ));
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

                // if (isPageVisible) // Only show if isPageVisible is true
                //   AnimatedPositioned(
                //     duration: Duration(milliseconds: 500),
                //     curve: Curves.easeInOut,
                //     bottom: 0,
                //     left: 0,
                //     right: 0,
                //     child: SlideUpPage(
                //       onClose: _togglePageVisibility,
                //     ),
                //   ),
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
                    : isComptaskSelected
                        ? SizedBox(height: 8.h)
                        : const SizedBox(),
                Expanded(
                  child: isComptaskSelected
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: ProgramList(
                            programs: programs,
                            sportsList: widget.interestList,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: TrainerList(),
                        ),
                ),
                // Sliding page
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramList extends StatefulWidget {
  final List<Map<String, dynamic>> programs;
  final List<String> sportsList;

  ProgramList({Key? key, required this.programs, required this.sportsList});

  @override
  _ProgramListState createState() => _ProgramListState();
}

class _ProgramListState extends State<ProgramList> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> extractedInfoList = [];
    for (var item in widget.programs) {
      item.forEach((sport, data) {
        if (data is List &&
            data.isNotEmpty &&
            data[0] == "True" &&
            widget.sportsList.contains(sport)) {
          var sportData = data[1];
          String courseName = sportData['CourseName'];
          String trainerName = sportData['TrainerName'];
          String duration = sportData['Duration'];
          String location = sportData['Location'];
          String description = sportData['Description'];
          String price = sportData['Price'];
          String learning = sportData['Learning'];
          String prerequisites =
              sportData['Prerequisites']; // Directly access as string
          List<String> prerequisitesList = prerequisites != null
              ? prerequisites.split(',').map((e) => e.trim()).toList()
              : [];
          String courseOutcome =
              sportData['CourseOutcome']; // Directly access as string
          List<String> courseOutcomeList = courseOutcome != null
              ? courseOutcome.split(',').map((e) => e.trim()).toList()
              : [];

          Map<String, dynamic> infoMap = {
            'Sport': sport,
            'CourseName': courseName,
            'TrainerName': trainerName,
            'Duration': duration,
            'Location': location,
            'Description': description,
            'Prerequisites': prerequisitesList,
            'CourseOutcome': courseOutcomeList,
            'Learning': learning,
            'Price': price
          };

          extractedInfoList.add(infoMap);
        }
      });
    }

    return ListView.builder(
      itemCount: extractedInfoList.length,
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Changed background color to white
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                  color: lightred2), // Added border with lightred2 color
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6.0.r),
                        child: Image.asset(
                          'assets/Dashboard/yoga-icon.png',
                          width: 64.w,
                          height: 64.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(extractedInfoList[index]['CourseName']!,
                                    style: dashboardtextstyle),
                                Container(
                                  height: 30.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: grey, // Set background color to grey
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.all(8.0.r),
                                  child: Row(
                                    children: [
                                      Text(
                                        '10+',
                                        style: GoogleFonts.inter(
                                            color:
                                                black700, // Set text color to black
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(width: 2.0.sp),
                                      Image.asset(
                                        'assets/Dashboard/people-icon.png',
                                        width: 10.w,
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(extractedInfoList[index]['TrainerName']!,
                                style: dashboardtextstyle2),
                            Row(
                              children: [
                                Text(extractedInfoList[index]['Duration']!,
                                    style: dashboardtextstyle2),
                                SizedBox(width: 10.w),
                                Text('• ', // Grey dot
                                    style: dashboardtextstyle2),
                                Text(extractedInfoList[index]['Location']!,
                                    style: dashboardtextstyle2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        Row(
                          children: [
                            for (var tag in ['Yoga', 'Fitness', 'Health'])
                              Container(
                                margin: EdgeInsets.only(right: 10.0.w),
                                padding: EdgeInsets.symmetric(vertical: 4.0.h),
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0.h, right: 10.h),
                                  child: Text(tag, // Tags
                                      style: dashboardtextstyle3),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: 8.h, left: 16.w, bottom: 8.h, right: 16.w),
                        foregroundColor: white400,
                        backgroundColor: red1,
                        minimumSize: Size(311.w, 32.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(13.r),
                        )),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => JoinCourse(
                                  courseId: index,
                                  courseInfo: extractedInfoList[index],
                                )),
                          ),
                        );
                      },
                      child:
                          Text('Join the Course', style: dashboardtextstyle4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TrainerList extends StatelessWidget {
  final List<Map<String, dynamic>> trainers = [
    {
      'category': 'Yoga',
      'ongoingPrograms': 3,
      'rating': 4.6,
      'name': 'Rajath K',
      'tags': ['Core', 'Full Body', 'Glutes'],
    },
    {
      'category': 'Yoga',
      'ongoingPrograms': 3,
      'rating': 4.6,
      'name': 'Rajath K',
      'tags': ['Core', 'Full Body', 'Glutes'],
    },
    {
      'category': 'Yoga',
      'ongoingPrograms': 3,
      'rating': 4.6,
      'name': 'Rajath K',
      'tags': ['Core', 'Full Body', 'Glutes'],
    },
    {
      'category': 'Yoga',
      'ongoingPrograms': 3,
      'rating': 4.6,
      'name': 'Rajath K',
      'tags': ['Core', 'Full Body', 'Glutes'],
    },
    {
      'category': 'Yoga',
      'ongoingPrograms': 3,
      'rating': 4.6,
      'name': 'Rajath K',
      'tags': ['Core', 'Full Body', 'Glutes'],
    },
  ];

  TrainerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: trainers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0.r),
              border: Border.all(color: Colors.red), // Red outline border
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(trainers[index]['category'], // Category
                          style: dashboardtextstyle5),
                      SizedBox(width: 5.w),
                      Text(
                        '•', // Dot separator
                        style: GoogleFonts.inter(
                          color: darkgrey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                          '${trainers[index]['ongoingPrograms']} Ongoing Programs', // Number of ongoing programs
                          style: dashboardtextstyle2),
                      const Spacer(), // Spacer to push the rating and name to the right
                      Container(
                        height: 30.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                          color: grey, // Set background color to grey
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${trainers[index]['rating']}',
                              style: GoogleFonts.inter(
                                color: Colors.black, // Set text color to black
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(width: 2.0.sp),
                            Image.asset(
                              'assets/Dashboard/star-icon.png',
                              // width: 10.w,
                              // height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25.r, // Adjust the size of the circular image
                        backgroundImage: const AssetImage(
                            'assets/Dashboard/trainer-icon.png'),
                      ),
                      SizedBox(
                          width: 10.0
                              .w), // Adjust the distance between the image and the text (name and tags
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trainers[index]['name'], // Trainer name
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              for (var tag in trainers[index]['tags'])
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 5.0.w, bottom: 5.0.h),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0.h, horizontal: 8.0.w),
                                  decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(10.0.r),
                                  ),
                                  child: Text(
                                    tag, // Tags
                                    style: GoogleFonts.inter(
                                      color: darkgrey,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
