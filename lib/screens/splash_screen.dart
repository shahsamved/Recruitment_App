import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main_screen.dart';
import 'package:recruitment/size_config.dart';

class SplashScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: MainScreen(),
      image: new Image.asset(
        'assets/images/logo.png',
      ),
      photoSize: SizeConfig.heightMultiplier * 11,
      title: new Text(
        'SUITIFY',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.heightMultiplier * 5,
            color: Colors.white),
      ),
      backgroundColor: Color(0xff1443C3),
      imageBackground: AssetImage(
        'assets/images/Pattern.png',
      ),
      loaderColor: Colors.white,
    );
  }
}
