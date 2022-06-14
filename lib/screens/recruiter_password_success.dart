import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_login.dart';
import 'package:recruitment/screens/recruiter_login.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'Reset_password.dart';
import 'candidate_register.dart';

class RPasswordSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          backgroundColor: kGrey,
          body: SafeArea(
              bottom: false,
              left: true,
              right: true,
              top: false,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset('assets/images/blue-black-logo.png',
                          height: SizeConfig.heightMultiplier * 15,
                          fit: BoxFit.contain)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 3.125,
                        horizontal: SizeConfig.widthMultiplier * 2.82),
                    child: FittedBox(
                      child: Text(
                        'Password reset successfully\nPlease login back  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.heightMultiplier * 2.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 3.125,
                        horizontal: SizeConfig.widthMultiplier * 2.82),
                    child: Container(
                      height: SizeConfig.heightMultiplier * 7,
                      width: SizeConfig.widthMultiplier * 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kBlue,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RLogin()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: SizeConfig.heightMultiplier * 2.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ))));
    });
  }
}
