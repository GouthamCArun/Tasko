import 'package:supabase_flutter/supabase_flutter.dart';

class FetchTaskService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    try {
      // Directly fetch the data without .execute()
      final response = await _supabase
          .from('tasks')
          .select('*')
          .eq('task_comp', false)
          .order('task_id',
              ascending: false); // Order by task_id in descending order

      if (response == null || response.isEmpty) {
        return [];
      }

      // Ensure the response is a list of maps
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }
}
