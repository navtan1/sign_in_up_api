import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sign_in_up_api/api_routes/api_routes.dart';

class SignInServices {
  static Future<bool> getSignIn({Map<String, dynamic>? reqBody}) async {
    Map<String, String> headers = {
      'Authorization': '\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0',
      'Client-Service': 'frontend-client',
      'User-ID': '1',
      'Auth-Key': 'simplerestapi',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    http.Response response = await http.post(Uri.parse(ApiRoutes.logIn),
        body: reqBody, headers: headers);

    var result = jsonDecode(response.body);
    print('Response======>>>>>>${jsonDecode(response.body)}');
    return result['status'];
  }
}
