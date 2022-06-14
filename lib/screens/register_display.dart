import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/recruiter_register.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pallete.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'candidate_register.dart';

class RegisterDisplay extends StatelessWidget {
  //static const routeName = "/registerdisplay";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kGrey,
        body: SafeArea(
          bottom: false,
          left: true,
          right: true,
          top: false,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: SizeConfig.heightMultiplier * 30,
                  child: ResponsiveWidget(
                    portraitLayout: TopPortrait(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              'Search Millions of Your',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.2,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.heightMultiplier * 2.2),
                              child: Text(
                                'Dream Jobs Online',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 1.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.heightMultiplier *
                                              3.5),
                                      child: Container(
                                        width: SizeConfig.widthMultiplier * 40,
                                        child: Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                SizeConfig.heightMultiplier *
                                                    1.2),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .heightMultiplier *
                                                    3.25),
                                            child: Column(
                                              children: [
                                                FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .heightMultiplier *
                                                            2.2,
                                                        bottom: SizeConfig
                                                                .heightMultiplier *
                                                            2.2),
                                                    child: Text(
                                                      'Recruiter',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            2.2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                R_Register()));
                                                  },
                                                  child: Image.asset(
                                                      'assets/images/arrow.png',
                                                      fit: BoxFit.contain),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.heightMultiplier * 8,
                                      height: SizeConfig.heightMultiplier * 8,
                                      decoration: ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.heightMultiplier * 0.5),
                                        child: CircleAvatar(
                                            radius:
                                                SizeConfig.heightMultiplier *
                                                    3.5,
                                            backgroundColor: Color(0xff1443C3),
                                            child: Image.asset(
                                                'assets/images/recruiter.png',
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    3,
                                                fit: BoxFit.contain)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.heightMultiplier *
                                              3.5),
                                      child: Container(
                                        width: SizeConfig.widthMultiplier * 40,
                                        child: Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                SizeConfig.heightMultiplier *
                                                    1.2),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .heightMultiplier *
                                                    3.25),
                                            child: Column(
                                              children: [
                                                FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .heightMultiplier *
                                                            2.2,
                                                        bottom: SizeConfig
                                                                .heightMultiplier *
                                                            2.2),
                                                    child: Text(
                                                      'Candidate',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            2.2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    // Navigator.of(context)
                                                    //     .pushNamed(
                                                    //         C_Register
                                                    //             .routeName,
                                                    //         arguments: {
                                                    //       'from':
                                                    //           RegisterDisplay()

                                                    //     });
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                C_Register()));
                                                  },
                                                  child: Image.asset(
                                                      'assets/images/arrow.png',
                                                      fit: BoxFit.contain),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.heightMultiplier * 8,
                                      height: SizeConfig.heightMultiplier * 8,
                                      decoration: ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.heightMultiplier * 0.5),
                                        child: CircleAvatar(
                                            radius:
                                                SizeConfig.heightMultiplier *
                                                    3.5,
                                            backgroundColor: Color(0xff1443C3),
                                            child: Image.asset(
                                                'assets/images/candidate.png',
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    3,
                                                fit: BoxFit.contain)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          ),
                        )),
                    Expanded(flex: 2, child: Container())
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class TopPortrait extends StatefulWidget {
  @override
  _TopPortraitState createState() => _TopPortraitState();
}

class _TopPortraitState extends State<TopPortrait> {
  @override
  int currentPos = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey,
      body: CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            height: SizeConfig.heightMultiplier * 55,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentPos = index;
              });
              print(currentPos);
            }),
        items: [
          //Image - 1
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            child: FractionallySizedBox(
              heightFactor: SizeConfig.heightMultiplier * 0.13,
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_bottom-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_top-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: SizeConfig.heightMultiplier * 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 0
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier * 1,
                            height: SizeConfig.heightMultiplier * 1,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 1
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 2
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 3
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                        ],
                      )),
                  Container(
                      child: Column(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/images/back-arrow.png',
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                              child: Image.asset(
                            'assets/images/suitify.png',
                          ))),
                      Expanded(flex: 2, child: Container())
                    ],
                  )),
                ],
              ),
            ),
          ),

          //Image -2
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            child: FractionallySizedBox(
              heightFactor: SizeConfig.heightMultiplier * 0.13,
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_bottom-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_top-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: SizeConfig.heightMultiplier * 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 0
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier * 1,
                            height: SizeConfig.heightMultiplier * 1,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 1
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 2
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 3
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                        ],
                      )),
                  Container(
                      child: Column(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/images/back-arrow.png',
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                              child: Image.asset(
                            'assets/images/suitify.png',
                          ))),
                      Expanded(flex: 2, child: Container())
                    ],
                  )),
                ],
              ),
            ),
          ),

          //Image -3
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            child: FractionallySizedBox(
              heightFactor: SizeConfig.heightMultiplier * 0.13,
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_bottom-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_top-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: SizeConfig.heightMultiplier * 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 0
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier * 1,
                            height: SizeConfig.heightMultiplier * 1,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 1
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 2
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 3
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                        ],
                      )),
                  Container(
                      child: Column(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/images/back-arrow.png',
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                              child: Image.asset(
                            'assets/images/suitify.png',
                          ))),
                      Expanded(flex: 2, child: Container())
                    ],
                  )),
                ],
              ),
            ),
          ),

          //Image-4
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            child: FractionallySizedBox(
              heightFactor: SizeConfig.heightMultiplier * 0.13,
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_bottom-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/register_display_cover_top-1.png',
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: SizeConfig.heightMultiplier * 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 0
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 0
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier * 1,
                            height: SizeConfig.heightMultiplier * 1,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 1
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 1
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 2
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 2
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                          Container(
                            width: SizeConfig.heightMultiplier,
                            height: SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: SizeConfig.heightMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 1.25,
                              decoration: currentPos == 3
                                  ? BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25),
                                          right: Radius.circular(
                                              SizeConfig.heightMultiplier *
                                                  1.25)),
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == 3
                                          ? Color(0xff1443C3)
                                          : Colors.white,
                                    )),
                        ],
                      )),
                  Container(
                      child: Column(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/images/back-arrow.png',
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                              child: Image.asset(
                            'assets/images/suitify.png',
                          ))),
                      Expanded(flex: 2, child: Container())
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
