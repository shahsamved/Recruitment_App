import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'Reset_password.dart';
import 'candidate_register.dart';
import 'recruiter_reset_password.dart';

class RForgotPassword extends StatefulWidget {
  @override
  _RForgotPasswordState createState() => _RForgotPasswordState();
}

class _RForgotPasswordState extends State<RForgotPassword> {
  var _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

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
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 4.25),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 3.25,
                            ),
                            child: Row(children: [
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Image.asset(
                                      'assets/images/black-arrow.png',
                                      width: SizeConfig.heightMultiplier * 1.5,
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
                                      'Forgot Password ',
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(flex: 4, child: Container()),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 1.25,
                                horizontal: SizeConfig.widthMultiplier * 3.82),
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.length != 10)
                                    return 'Mobile Number must be of 10 digit';

                                  return null;
                                },
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[350],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[350],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[350],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  contentPadding: EdgeInsets.all(
                                      SizeConfig.heightMultiplier * 1.25),
                                  hintText: 'Enter Mobile Number',
                                  hintStyle: kBodyText,
                                ),
                                style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.5,
                                  color: Colors.black,
                                  height: SizeConfig.heightMultiplier * 0.1875,
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 3.125,
                                horizontal: SizeConfig.widthMultiplier * 3.82),
                            child: Container(
                              height: SizeConfig.heightMultiplier * 7,
                              width: SizeConfig.widthMultiplier * 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: kBlue,
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  //if (_formKey.currentState.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RResetPassword()));
                                  //}
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))));
    });
  }
}
