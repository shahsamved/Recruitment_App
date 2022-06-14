import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/menu.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        bottom: false,
        left: true,
        right: true,
        top: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 8.5,
              ),
              child: Row(children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (Menu()))),
                      child: Image.asset(
                        'assets/images/black-arrow.png',
                        width: SizeConfig.heightMultiplier * 1.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 8, child: Container()),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Text(
                      'Settings',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.heightMultiplier * 3,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 8, child: Container()),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.heightMultiplier * 4,
                  right: SizeConfig.heightMultiplier * 4),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 7,
                        bottom: SizeConfig.heightMultiplier * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Permissions',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.4,
                                color: Color(0xff242E42))),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: SizeConfig.heightMultiplier * 2.4,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 2,
                        bottom: SizeConfig.heightMultiplier * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Legal & About',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.4,
                                color: Color(0xff242E42))),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: SizeConfig.heightMultiplier * 2.4,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 2,
                        bottom: SizeConfig.heightMultiplier * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Send Feedback',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.4,
                                color: Color(0xff242E42))),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: SizeConfig.heightMultiplier * 2.4,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 2,
                        bottom: SizeConfig.heightMultiplier * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Support',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.4,
                                color: Color(0xff242E42))),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: SizeConfig.heightMultiplier * 2.4,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
