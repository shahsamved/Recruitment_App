import "package:flutter/material.dart";
import 'package:otp_text_field/otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/model/ProgressHUD.dart';
import 'package:recruitment/model/httpException.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/screens/candidate_complete_profile.dart';
import 'package:recruitment/screens/candidate_home_page.dart';
import 'package:recruitment/screens/candidate_login.dart';
import 'package:recruitment/screens/recruiter_login.dart';
import '/pallete.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';

import 'recruiter_complete_profile.dart';

class ROtpScreen extends StatefulWidget {
  static const routeName = "/rotp";

  @override
  _ROtpScreenState createState() => _ROtpScreenState();
}

class _ROtpScreenState extends State<ROtpScreen> {
  bool isLoad = false;
  bool isInitial;
  var _isLoading = false;
  String $otp;
  Map<String, String> _userData = {
    'phone': '',
    'otp': '',
  };

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      print("try");
      print(_userData['phone']);
      print(_userData['otp']);
      await Provider.of<Auth>(context, listen: false).rotpVerify(
        _userData['otp'],
        _userData['phone'],
      );
      print("here");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecruiterCompleteProfile()));
    } on HttpException catch (error) {
      print("here1");
      print(_userData['phone']);
      print(_userData['otp']);
      print(error.toString());
      showAlertDialog(context);
    } catch (error) {
      print("here2");
      print(error);
      showAlertDialog(context);
      const errorMessage = 'Could not verify otp. Please try again later';
      print(errorMessage);
    }

    setState(() {
      _isLoading = false;
      isLoad = false;
    });
  }

  Future<void> resendotp() async {
    try {
      await Provider.of<Auth>(context, listen: false).rresendOtp();
    } catch (error) {
      print("here2");
      print(error);
      //showAlertDialog(context);
      const errorMessage = 'Please try again later';
      print(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isLoad,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    var details =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
            backgroundColor: kGrey,
            body: SafeArea(
                bottom: false,
                left: true,
                right: true,
                top: false,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 8.5,
                            bottom: SizeConfig.heightMultiplier * 4,
                            left: SizeConfig.heightMultiplier * 1.8,
                            right: SizeConfig.heightMultiplier * 1.8),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          SizeConfig.heightMultiplier),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Image.asset(
                                                  'assets/images/black_back_arrow.png',
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1.5,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(flex: 2, child: Container()),
                                          Expanded(
                                              flex: 6,
                                              child: Container(
                                                child: FittedBox(
                                                  child: Text(
                                                    'OTP Verification',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            2.6,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                          Expanded(flex: 3, child: Container()),
                                        ],
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              'Enter the OTP sent on',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .heightMultiplier *
                                                    2.4,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                    .heightMultiplier),
                                            child: FittedBox(
                                              child: Text(
                                                details['phone'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      2.4,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        children: [
                                          OTPTextField(
                                            length: 4,
                                            width:
                                                SizeConfig.widthMultiplier * 80,
                                            fieldWidth:
                                                SizeConfig.widthMultiplier * 12,
                                            style: TextStyle(fontSize: 17),
                                            textFieldAlignment:
                                                MainAxisAlignment.spaceAround,
                                            onChanged: (pin) {
                                              print("Changed: " + pin);
                                            },
                                            onCompleted: (pin) {
                                              print("Completed: " + pin);
                                              print("hello");
                                              _userData['otp'] = pin;
                                              _userData['phone'] =
                                                  details['phone'];
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .heightMultiplier *
                                                    5),
                                            child: FittedBox(
                                              child: Text(
                                                'Did not receive the OTP?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      2.4,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .heightMultiplier *
                                                    1.7),
                                            child: InkWell(
                                              child: FittedBox(
                                                child: Text(
                                                  'Re-send OTP',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2.4,
                                                      color: kBlue),
                                                ),
                                              ),
                                              onTap: () {
                                                resendotp();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(flex: 8, child: Container()),
                                  ],
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: SizeConfig.widthMultiplier * 90,
                                height: SizeConfig.heightMultiplier * 5,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kBlue,
                                  ),
                                  child: FlatButton(
                                    onPressed: () {
                                      print("calling submit");
                                      _submit();
                                    },
                                    child: Text(
                                      'Verify',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConfig.textMultiplier * 2.3),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      },
    );
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
    content: Text("OTP Invalid, Please try again"),
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
