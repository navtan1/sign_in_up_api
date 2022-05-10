import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_up_api/view/home_page.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animation;

  String? userpassword;

  @override
  void initState() {
    getData().whenComplete(() => Timer(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  userpassword == null ? const IntroScreen() : const HomePage(),
            ),
          );
        }));
    animation =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation!.repeat();
    super.initState();
  }

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? obtained = prefs.getString('Password');

    setState(() {
      userpassword = obtained;
    });
  }

  @override
  void dispose() {
    animation!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: animation!.view,
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation!.value * 2 * pi,
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/shadow.svg',
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/blob.svg',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Center(
              child: Text(
                'S',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
