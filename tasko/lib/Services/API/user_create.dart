import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class UserCreate {
  Future createUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("-Details uploading Started -");
    final String? phoneNo = prefs.getString('phoneNo');
    final String? name = prefs.getString('Name');
    final String? email = prefs.getString('Email');
    final String gender = prefs.getString('gender') ?? 'Male';
    final String? dob = prefs.getString('dob');
    final double? weight = prefs.getDouble('weight');
    final double? height = prefs.getDouble('height');
    final List interests = prefs.getStringList('interests') ?? [];
    final String location = prefs.getString('Location') ?? 'Unknown';
    print(jsonEncode(interests));
    // try {
    //   var response =
    //       await http.post(Uri.parse('${ApiConfig.baseUrl}create/'), body: {
    //     "number": phoneNo,
    //     "name": name,
    //     "email": email,
    //     "gender": gender,
    //     "dob": dob,
    //     "weight": weight,
    //     "height": height
    //   });
    //   // String responseData = json.decode(response.body);
    //   // String weightAsString = responseData['weight'].toString();
    //   // String heightAsString = responseData['height'].toString();

    //   // print(json.decode(response.body));
    //   print('done');
    //   return 'success';
    // } catch (e) {
    //   print("Error $e");
    //   return ("error");
    // }
    try {
      var response =
          await http.post(Uri.parse('${ApiConfig.baseUrl}create/'), body: {
        "number": phoneNo,
        "name": name,
        "email": email,
        "gender": gender,
        "dob": dob,
        "weight": weight.toString(), // Convert double to String
        "height": height.toString(), // Convert double to String
       "interests": jsonEncode(interests),
        "location": location
      });
      Map responseData = json.decode(response.body);
      print(responseData);
      return 'success';
    } catch (e) {
      print("Error $e");
      return "error";
    }
  }
}
