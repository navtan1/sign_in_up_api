import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_up_api/api_services/log_in_services.dart';
import 'package:sign_in_up_api/common/password_textfeld.dart';
import 'package:sign_in_up_api/model/req/log_in_model.dart';
import 'package:sign_in_up_api/view/sign_up_screen.dart';
import 'package:sizer/sizer.dart';

import 'home_page.dart';
import 'intro_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();

  final _userId = TextEditingController();
  final _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IntroScreen(),
                                    ));
                              },
                              icon: Icon(Icons.keyboard_backspace_outlined)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SvgPicture.asset('assets/images/s.svg'),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Login to you account',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      height: 8.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30.sp),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.perm_identity_outlined,
                          color: Colors.black,
                        ),
                        title: TextFormField(
                          validator: (value) {
                            if (value!.length < 4) {
                              return 'enter valid username';
                            }
                          },
                          controller: _userId,
                          decoration: InputDecoration(
                            hintText: 'user id',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Password(
                      controller: _passWord,
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'enter valid username';
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text('Forget password?')],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_form.currentState!.validate()) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString('Password', _passWord.text);

                          LogInModel _model = LogInModel();
                          _model.username = _userId.text;
                          _model.password = _passWord.text;

                          bool status = await LogInServices.getLogIn(
                              reqBody: _model.toJson());

                          if (status == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                  content: Text('successfully'),
                                  duration: Duration(seconds: 2),
                                ))
                                .closed
                                .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('fail'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      },
                      child: SizedBox(
                        height: 8.h,
                        width: 80.w,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          color: Color(0xff7462FF),
                          child: Center(
                            child: Text(
                              'Login to account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(color: Color(0xff7462FF)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
