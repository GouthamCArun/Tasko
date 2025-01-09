import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/Services/API/fetch_completed_task.dart';
import 'package:tasko/Services/API/fetch_task.dart';

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
                          child: TaskList())
                      : Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CompletedTaskList()),
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

class CompletedTaskList extends StatefulWidget {
  @override
  _CompletedTaskListState createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  final CompletedTaskService _completedTaskService = CompletedTaskService();
  late Future<List<Map<String, dynamic>>> _completedTasks;

  @override
  void initState() {
    super.initState();
    _completedTasks = _completedTaskService.fetchCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _completedTasks,
      builder: (context, snapshot) {
        // Checking if the connection is still waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Handle errors with a null check for data
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Check if there's no data
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No completed tasks available.'));
        }

        // Extract the data safely
        List<Map<String, dynamic>> extractedInfoList = snapshot.data!;
        print(extractedInfoList);
        return ListView.builder(
          itemCount: extractedInfoList.length,
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (context, index) {
            // Null checks before accessing data
            var courseName =
                extractedInfoList[index]['task_name'] ?? 'Unknown Task ';
            var trainerName = extractedInfoList[index]['task_desc'] ?? '.....';
            var duration = extractedInfoList[index]['task_date'] ?? 'N/A';
            var location =
                extractedInfoList[index]['task_time'] ?? 'Unknown Location';

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.red),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Image.asset(
                              'assets/Dashboard/yoga-icon.png',
                              width: 64.0,
                              height: 64.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      courseName,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 30.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '10+',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.0),
                                          ),
                                          SizedBox(width: 2.0),
                                          Image.asset(
                                            'assets/Dashboard/people-icon.png',
                                            width: 10.0,
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  trainerName,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Row(
                                  children: [
                                    Text(duration,
                                        style: TextStyle(fontSize: 14.0)),
                                    SizedBox(width: 10.0),
                                    Text('• ',
                                        style: TextStyle(fontSize: 14.0)),
                                    Text(location,
                                        style: TextStyle(fontSize: 14.0)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        child: Row(
                          children: [
                            SizedBox(width: 8.0),
                            Row(
                              children: [
                                for (var tag in ['Yoga', 'Fitness', 'Health'])
                                  Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(tag,
                                          style: TextStyle(fontSize: 12.0)),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                          ),
                          onPressed: () async {
                            // Navigate to JoinCourse or handle accordingly
                            // await Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => JoinCourse(
                            //       courseId: index,
                            //       courseInfo: extractedInfoList[index],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Text('Join the Course',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final FetchTaskService _fetchTaskService = FetchTaskService();
  late Future<List<Map<String, dynamic>>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = _fetchTaskService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final taskName = task['task_name'] ?? 'Unnamed Task';
              final taskDesc = task['task_desc'];
              final taskDate = task['task_date'];
              final taskTime = task['task_time'];
              final taskCompleted = task['task_comp'] == true;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task Name and Status
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                taskName,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: taskCompleted
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                taskCompleted ? 'Completed' : 'Pending',
                                style: TextStyle(
                                  color:
                                      taskCompleted ? Colors.green : Colors.red,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),

                        // Task Description
                        if (taskDesc != null)
                          Text(
                            taskDesc,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                        const SizedBox(height: 10.0),

                        // Task Date and Time
                        Row(
                          children: [
                            if (taskDate != null)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16.0,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    taskDate,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            const Spacer(),
                            if (taskTime != null)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16.0,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    taskTime,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                    ),
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
        },
      ),
    );
  }
}
