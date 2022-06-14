import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recruitment/screens/candidate_register.dart';
import 'package:recruitment/screens/register_display.dart';
import 'package:recruitment/size_config.dart';
import '/pallete.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget box = Container(
        padding: EdgeInsets.only(
            left: 4 * SizeConfig.widthMultiplier,
            right: 4 * SizeConfig.widthMultiplier,
            bottom: 4 * SizeConfig.widthMultiplier,
            top: 5 * SizeConfig.widthMultiplier),
        child: Column(children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    '\"Some ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.heightMultiplier * 2.2,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    '1.9 Crore ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.heightMultiplier * 2.2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1443C3)),
                  ),
                ),
                FittedBox(
                  child: Text(
                    'salaried, formal ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.heightMultiplier * 2.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'economy jobs have been lost after the',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'lockdown, estimates the CMIE.\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              'A separate report by the International',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.heightMultiplier * 2.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'Labour Organization(ILO) and the Asian',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'Development Bank (ADB) estimates',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'that more than 40 lacs Indians below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'the age of 30 have lost their jobs due to',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'the Pandemic.\"\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
              bottom: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                '- BBC News',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
        ]));

    Widget text1 = Container(
        padding: EdgeInsets.only(
            left: 4 * SizeConfig.widthMultiplier,
            right: 4 * SizeConfig.widthMultiplier,
            bottom: 4 * SizeConfig.widthMultiplier),
        child: Column(children: [
          FittedBox(
            child: Text(
              'We are building a strong community of',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.heightMultiplier * 2.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 0.5,
                bottom: SizeConfig.heightMultiplier * 0.5),
            child: FittedBox(
              child: Text(
                'JOB SEEKERS AND RECRUITERS',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SizeConfig.heightMultiplier * 2.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1443C3)),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              'to help those who have lost their JOBS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.heightMultiplier * 2.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text(
                'due to the Pandemic',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                ),
              ),
            ),
          ),
        ]));

    Widget button = Container(
        height: SizeConfig.heightMultiplier * 9,
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier * 70,
              height: SizeConfig.heightMultiplier * 11,
              child: FlatButton(
                  color: Color(0xff1443C3),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterDisplay()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: SizeConfig.heightMultiplier * 2.25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ));

    Widget text2 = Container(
        padding: EdgeInsets.only(
            left: 4 * SizeConfig.widthMultiplier,
            right: 4 * SizeConfig.widthMultiplier,
            top: 3 * SizeConfig.widthMultiplier,
            bottom: 4 * SizeConfig.widthMultiplier),
        child: Column(children: [
          FittedBox(
            child: Text(
              'here if you are looking for',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.heightMultiplier * 2.2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 0.5,
                    bottom: SizeConfig.heightMultiplier * 0.5),
                child: FittedBox(
                  child: Text(
                    'JOB',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.heightMultiplier * 2.2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1443C3)),
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  ' or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.heightMultiplier * 2.2,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  ' CANDIDATE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.heightMultiplier * 2.2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1443C3)),
                ),
              ),
            ],
          ),
          SizedBox(height: 3 * SizeConfig.widthMultiplier),
          FittedBox(
            child: Text(
              'Note: Priority will be given to those',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 2.2,
                  color: Color(0xffFF2C2C)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 0.5,
            ),
            child: FittedBox(
              child: Text('who have lost their job',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.heightMultiplier * 2.2,
                      color: Color(0xffFF2C2C))),
            ),
          ),
        ]));

    Widget logo = Container(
      height: 17 * SizeConfig.heightMultiplier,
      width: 25 * SizeConfig.widthMultiplier,
      child: SvgPicture.asset(
        "assets/images/main_screen_logo.svg",
        height: 13 * SizeConfig.heightMultiplier,
        fit: BoxFit.contain,
      ),
    );

    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              left: 4 * SizeConfig.widthMultiplier,
              right: 4 * SizeConfig.widthMultiplier,
              top: 8 * SizeConfig.heightMultiplier,
              bottom: 2 * SizeConfig.heightMultiplier),
          child: SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(children: [
                logo,
                box,
                text1,
                button,
                text2,
              ]),
            ),
          )),
        ),
      );
    });
  }
}
