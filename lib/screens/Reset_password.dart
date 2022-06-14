import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'Reset_password.dart';
import 'candidate_password_successful.dart';
import 'candidate_register.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
      TextEditingController password = TextEditingController();
      TextEditingController confirmpassword = TextEditingController();
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
                                    'Reset Password ',
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
                              controller: password,
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
                                hintText: 'Password',
                                hintStyle: kBodyText,
                              ),
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                color: Colors.black,
                                height: SizeConfig.heightMultiplier * 0.1875,
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter new password!';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 1.25,
                              horizontal: SizeConfig.widthMultiplier * 3.82),
                          child: Center(
                            child: TextFormField(
                              controller: confirmpassword,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please re-enter password';
                                }
                                // print(password.text);
                                // print(confirmpassword.text);
                                if (password.text != confirmpassword.text) {
                                  return "Password does not match";
                                }
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
                                hintText: 'Confirm New Password',
                                hintStyle: kBodyText,
                              ),
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                color: Colors.black,
                                height: SizeConfig.heightMultiplier * 0.1875,
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
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
                                // if (_formKey.currentState.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordSuccess()));
                                //}
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    fontSize: SizeConfig.heightMultiplier * 2.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ))));
    });
  }
}
