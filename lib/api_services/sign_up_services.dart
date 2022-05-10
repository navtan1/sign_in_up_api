import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sign_in_up_api/api_routes/api_routes.dart';

class SignUpServices<bool> {
  static Future getSignUp({Map<String, dynamic>? reqBody}) async {
    http.Response response =
        await http.post(Uri.parse(ApiRoutes.signUp), body: reqBody);

    var result = jsonDecode(response.body);
    print('Response====>>>>>${jsonDecode(response.body)}');
    return result;
  }
}
