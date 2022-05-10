import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_up_api/api_services/sign_up_services.dart';
import 'package:sign_in_up_api/common/password_textfeld.dart';
import 'package:sign_in_up_api/model/req/sign_up_model.dart';
import 'package:sign_in_up_api/view/intro_screen.dart';
import 'package:sign_in_up_api/view/log_in_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();

  final _firstName = TextEditingController();

  final _lastName = TextEditingController();

  final _userId = TextEditingController();

  final _passWord = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    var pickerImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickerImage != null) {
        _image = File(pickerImage.path);
      }
    });
  }

  Future uploadImage({String? filename}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'avatar':
          await dio.MultipartFile.fromFile(_image!.path, filename: filename)
    });

    dio.Response response = await dio.Dio().post(
        "https://codelineinfotech.com/student_api/User/user_avatar_upload.php",
        data: formData);

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
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
                                    builder: (context) => const IntroScreen(),
                                  ));
                            },
                            icon:
                                const Icon(Icons.keyboard_backspace_outlined)),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: 15.h,
                      width: 30.w,
                      color: Colors.grey.shade400,
                      child: _image == null
                          ? const Icon(Icons.camera)
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const Text(
                    'Sign up to start learning',
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
                      leading: const Icon(
                        Icons.perm_identity_outlined,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter some value';
                          }
                        },
                        controller: _firstName,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 8.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.perm_identity_outlined,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter some value';
                          }
                        },
                        controller: _lastName,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 8.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.perm_identity_outlined,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        validator: (value) {
                          if (value!.length < 4) {
                            return 'atlest 4 character';
                          }
                        },
                        controller: _userId,
                        decoration: const InputDecoration(
                          hintText: 'User Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Password(
                    controller: _passWord,
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'atlest 8 character';
                      }
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [Text('Forget password?')],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_form.currentState!.validate()) {
                        String url = await uploadImage(
                            filename:
                                "${DateTime.now()}${Random().nextInt(1000)}${_image!.path}");

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setString('Password', _passWord.text);

                        SignUpModel _model = SignUpModel();
                        _model.firstName = _firstName.text;
                        _model.lastName = _lastName.text;
                        _model.username = _userId.text;
                        _model.password = _passWord.text;
                        _model.avatar = url;

                        bool status = await SignUpServices.getSignUp(
                          reqBody: _model.toJson());

                        if (status == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  content: Text('Successfully !'),
                                  duration: Duration(seconds: 2),
                                ),
                              )
                              .closed
                              .then(
                                (value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('failed'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    child: SizedBox(
                      height: 8.h,
                      width: 80.w,
                      child: const Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color: Color(0xff7462FF),
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInScreen(),
                                ));
                          },
                          child: const Text(
                            'Sign in',
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
    );
  }
}
