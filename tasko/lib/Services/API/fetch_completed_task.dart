import 'package:supabase_flutter/supabase_flutter.dart';

class CompletedTaskService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchCompletedTasks() async {
    try {
      // Use a filter to fetch records where task_comp is true
      final response = await _supabase
          .from('tasks')
          .select('*')
          .eq('task_comp', true); // Filter for completed tasks

      if (response == null || response.isEmpty) {
        return [];
      }

      // Ensure the response is a list of maps
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching completed tasks: $e');
      return [];
    }
  }
}
