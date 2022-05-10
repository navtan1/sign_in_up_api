import 'package:flutter/material.dart';
import 'package:sign_in_up_api/api_services/sign_in_services.dart';
import 'package:sign_in_up_api/model/req/sign_in_model.dart';

class LogUp extends StatelessWidget {
  LogUp({Key? key}) : super(key: key);

  final _email = TextEditingController();
  final _passWord = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 120,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(hintText: 'Mobile No'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passWord,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      LogUpModel _model = LogUpModel();
                      _model.email = _email.text;
                      _model.password = _passWord.text;
                      _model.clientKey = '1595922666X5f1fd8bb5f662';
                      _model.deviceType = 'MOB';

                      bool status = await SignInServices.getSignIn(
                          reqBody: _model.toJson());

                      if (status == true) {}
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
