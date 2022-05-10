import 'package:http/http.dart' as http;
import 'package:sign_in_up_api/api_routes/api_routes.dart';
import 'package:sign_in_up_api/model/res/all_users_model.dart';

class AllUsersServices {
  static Future<AllUsersModel?> getUserData() async {
    http.Response response = await http.get(Uri.parse(ApiRoutes.allUsers));

    return allUsersModelFromJson(response.body);
  }
}
