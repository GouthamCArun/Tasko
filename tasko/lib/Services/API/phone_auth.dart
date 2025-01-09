import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api_config.dart';

class PhoneAuth {
  static validatenumber(String number) async {
    print("- Number validation Started -");
    try {
      var response = await http.post(Uri.parse('${ApiConfig.baseUrl}validate/'),
          body: {"number": number});
      String responseData = json.decode(response.body);
      print(responseData);
      return 'success';
    } catch (e) {
      print("Error $e");
      return ("error");
    }
  }

  static verifyOtp(String number, String otp) async {
    print("- Number verification Started -");
    print(otp);
    try {
      var response = await http.post(Uri.parse('${ApiConfig.baseUrl}otp/'),
          body: {"number": number, "otp": otp});
      String responseData = json.decode(response.body);
      print(responseData);
      return responseData;
    } catch (e) {
      print("Error $e");
      return ("error");
    }
  }
}
