import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/Services/API/fetch_completed_task.dart';
import 'package:tasko/Services/API/fetch_task.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
