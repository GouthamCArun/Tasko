import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> markTaskAsComplete(int taskId) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase.from('tasks').update({
      'task_comp': true, // Set task_comp to true
    }).eq('id',
        taskId); // Make sure to replace 'id' with the appropriate column name if it's different

    if (response.error != null) {
      print('Error updating task: ${response.error?.message}');
    } else {
      print('Task marked as complete: $response');
    }
  } catch (e) {
    print('Error updating task: $e');
  }
}
