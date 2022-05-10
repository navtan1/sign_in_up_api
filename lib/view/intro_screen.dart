import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sign_in_up_api/view/log_in_screen.dart';
import 'package:sign_in_up_api/view/sign_up_screen.dart';
import 'package:sizer/sizer.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SvgPicture.asset('assets/images/intro.svg'),
              SizedBox(
                height: 2.h,
              ),
              SvgPicture.asset('assets/images/s.svg'),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                'Learn new skills',
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              const Text(
                'online!',
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              const Text(
                'Learn anything and compete with',
              ),
              const Text(
                'your friends and get rewards',
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
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
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInScreen(),
                      ));
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
                        'log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
