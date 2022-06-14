import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/screens/Contact_Us.dart';
import 'package:recruitment/screens/candidate_Notification.dart';
import 'package:recruitment/screens/candidate_home_page.dart';
import 'package:recruitment/screens/candidate_login.dart';
import 'package:recruitment/screens/candidate_profile.dart';
import 'package:recruitment/screens/main_screen.dart';
import 'package:recruitment/screens/settings.dart';
import 'package:recruitment/size_config.dart';
import '/pallete.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isLoad = false;

  var _isLoading = false;
  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).logout();
      print("here");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (MainScreen())));
    } on HttpException catch (error) {
      // print("here1");
      // //print(error.toString());
      // showAlertDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (MainScreen())));
    } catch (error) {
      // print("here2");
      // print(error);
      // showAlertDialog(context);
      // const errorMessage = 'Logout Failed';
      // print(errorMessage);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (MainScreen())));
    }

    setState(() {
      _isLoading = false;
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlue,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    child: Image.asset('assets/images/suitify.png',
                        height: SizeConfig.heightMultiplier * 15,
                        fit: BoxFit.contain)),
              ),
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.heightMultiplier * 0.5),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      (CandidateNotification()))),
                          child: Center(
                            child: Text(
                              'Notification',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (UserProfileScreen()))),
                          child: Center(
                            child: Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (Settings()))),
                          child: Center(
                            child: Text(
                              'Settings',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (ContactUs()))),
                          child: Center(
                            child: Text(
                              'Contact us',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => _submit(),
                          child: Center(
                            child: Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 3,
                      child: Container(
                          height: SizeConfig.heightMultiplier * 7.2,
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CandidateHomePage())),
                            child: Image.asset('assets/images/cancel.png',
                                height: SizeConfig.heightMultiplier * 7.2,
                                fit: BoxFit.fitHeight),
                          )),
                    ),
                    Expanded(flex: 2, child: Container())
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Failed to logout. Try Again"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
