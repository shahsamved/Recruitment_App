import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/model/ProgressHUD.dart';
import 'package:recruitment/model/httpException.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/Forgot_password.dart';
import 'package:recruitment/screens/candidate_home_page.dart';
import 'package:recruitment/screens/register_display.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'candidate_complete_profile.dart';
import 'candidate_register.dart';

class CLogin extends StatefulWidget {
  @override
  _CLoginState createState() => _CLoginState();
}

class _CLoginState extends State<CLogin> {
  bool valuefirst = false;
  var _formKey = GlobalKey<FormState>();
  bool isLoad = false;
  bool isInitial;
  var _isLoading = false;
  Map<String, String> _userData = {
    'phone': '',
    'password': '',
  };
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _userData['phone'],
        _userData['password'],
      );
      print("here");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CandidateHomePage()));
    } on HttpException catch (error) {
      print("here1");
      print(error.toString());
      showAlertDialog(context);
    } catch (error) {
      print("here2");
      print(error);
      showAlertDialog(context);
      const errorMessage = 'Could not Login. Please try again later';
      print(errorMessage);
    }

    setState(() {
      _isLoading = false;
      isLoad = false;
    });
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
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          backgroundColor: kGrey,
          body: SafeArea(
              bottom: false,
              left: true,
              right: true,
              top: false,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 30,
                              child: ResponsiveWidget(
                                portraitLayout: TopContainerPortrait(),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 1.25 * SizeConfig.heightMultiplier,
                                      bottom:
                                          1.25 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Container(
                                      child: Text(
                                        "Candidate Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                SizeConfig.textMultiplier * 3),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 9,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      1.25,
                                                  horizontal: SizeConfig
                                                          .widthMultiplier *
                                                      3.82),
                                              child: Center(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value.length != 10)
                                                      return 'Mobile Number must be of 10 digit';

                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    _userData['phone'] =
                                                        (value);
                                                    print(_userData['phone']);
                                                  },
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    contentPadding: EdgeInsets
                                                        .all(SizeConfig
                                                                .heightMultiplier *
                                                            1.25),
                                                    hintText: 'Mobile Number',
                                                    hintStyle: kBodyText,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        2.5,
                                                    color: Colors.black,
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        0.1875,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      1.25,
                                                  horizontal: SizeConfig
                                                          .widthMultiplier *
                                                      3.82),
                                              child: Center(
                                                child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    contentPadding: EdgeInsets
                                                        .all(SizeConfig
                                                                .heightMultiplier *
                                                            1.25),
                                                    hintText: 'Password',
                                                    hintStyle: kBodyText,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        2.5,
                                                    color: Colors.black,
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        0.1875,
                                                  ),
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Enter a password!';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    _userData['password'] =
                                                        (value);
                                                    print(
                                                        _userData['password']);
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .widthMultiplier *
                                                      3.8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Checkbox(
                                                      activeColor: kBlue,
                                                      checkColor: Colors.white,
                                                      value: this.valuefirst,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          this.valuefirst =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: FittedBox(
                                                      child: Text(
                                                        'Remember Me  ',
                                                        //textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: SizeConfig
                                                                  .heightMultiplier *
                                                              2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container()),
                                                  Expanded(
                                                    flex: 4,
                                                    child: FittedBox(
                                                      child: InkWell(
                                                        child: Text(
                                                          'Forgot Password?',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .heightMultiplier *
                                                                  2.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff1443C3)),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ForgotPassword()));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      3.125,
                                                  horizontal: SizeConfig
                                                          .widthMultiplier *
                                                      3.82),
                                              child: Container(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    7,
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        300,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: kBlue,
                                                ),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    _submit();
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             CandidateHomePage()));
                                                  },
                                                  child: Text(
                                                    'Sign In',
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            2.5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Expanded(flex: 2, child: Container()),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            'Don\'t have an account? ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: InkWell(
                                            child: Text(
                                              'Sign Up',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff1443C3)),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          C_Register()));
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                  Expanded(flex: 1, child: Container()),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              )));
    });
  }
}

class TopContainerPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: SizeConfig.heightMultiplier * 0.1175,
      alignment: Alignment.topCenter,
      child: Container(
          padding: EdgeInsets.only(top: 3.0 * SizeConfig.heightMultiplier),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
            color: Color(0xff1443C3),
          ),
          child: Column(
            children: [
              Expanded(flex: 2, child: Container()),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             RegisterDisplay()));
                              },
                              child: Image.asset(
                                'assets/images/back-arrow.png',
                                height: SizeConfig.heightMultiplier * 1.5,
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
                  flex: 6,
                  child: Container(
                      child: Image.asset('assets/images/suitify.png',
                          height: SizeConfig.heightMultiplier * 15,
                          fit: BoxFit.contain))),
              Expanded(flex: 1, child: Container())
            ],
          )),
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
    content: Text("Failed to Login. Try Again"),
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
