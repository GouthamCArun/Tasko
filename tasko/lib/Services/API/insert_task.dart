import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> insertTask({
  required String taskName,
  String? taskDesc,
  DateTime? taskDate,
  String? taskTime,
  bool? taskComp,
  String? taskType,
}) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase.from('tasks').insert({
      'task_name': taskName,
      'task_desc': taskDesc,
      'task_date': taskDate
          ?.toIso8601String()
          .split('T')
          .first, // Format to 'YYYY-MM-DD'
      'task_time': taskTime,
      'task_comp': taskComp,
      'task_type': taskType,
    });

    if (response != null) {
      print('Error: No data returned from the server.');
    } else {
      print('Task inserted successfully: $response');
    }
  } catch (e) {
    print('Error inserting task: $e');
  }
}
