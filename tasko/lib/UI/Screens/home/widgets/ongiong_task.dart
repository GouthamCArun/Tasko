import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/Services/API/fetch_completed_task.dart';
import 'package:tasko/Services/API/fetch_task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tasko/UI/Themes/colors.dart';

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
                    border: Border.all(color: red),
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
                                    color: red,
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
                                    color: red,
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
