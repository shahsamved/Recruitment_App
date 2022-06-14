import 'package:flutter/material.dart';
import 'package:recruitment/pallete.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main_screen.dart';
import 'package:recruitment/size_config.dart';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: kBlue),
        child: Center(
          child: Image.asset(
            'assets/images/mainlogowithtext.png',
          ),
        ));
  }
}
