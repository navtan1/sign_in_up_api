import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_up_api/api_services/log_up_services.dart';
import 'package:sign_in_up_api/model/req/log_up_model.dart';
import 'package:sign_in_up_api/view/home_page.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _fName = TextEditingController();

  final _lName = TextEditingController();

  final _email = TextEditingController();

  final _mobile = TextEditingController();

  final _dob = TextEditingController();

  final _password = TextEditingController();

  final _confirmPassword = TextEditingController();

  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    var pickerImag = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickerImag != null) {
        _image = File(pickerImag.path);
      }
    });
  }

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
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: 100,
                      width: 120,
                      color: Colors.red,
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.camera),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _fName,
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                  TextField(
                    controller: _lName,
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  TextField(
                    controller: _mobile,
                    decoration: InputDecoration(hintText: 'Mobile No'),
                  ),
                  TextField(
                    controller: _dob,
                    decoration: InputDecoration(hintText: 'DOB'),
                  ),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  TextField(
                    controller: _confirmPassword,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Log_Up_Model _model = Log_Up_Model();
                      _model.fname = _fName.text;
                      _model.lname = _lName.text;
                      _model.email = _email.text;
                      _model.mobile = _mobile.text;
                      _model.dob = _dob.text;
                      _model.password = _password.text;
                      _model.confirmPassword = _confirmPassword.text;
                      _model.clientKey = '1595922666X5f1fd8bb5f662';
                      _model.deviceType = 'MOB';

                      LogUpServices.getLogUp(reqBody: _model.toJson()).then(
                          (value) => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text('successfully !')))
                              .closed
                              .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ))));
                    },
                    child: Text('Register'),
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
