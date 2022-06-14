import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
      TextEditingController Name = TextEditingController();
      TextEditingController Email = TextEditingController();
      TextEditingController Message = TextEditingController();
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
                              vertical: SizeConfig.heightMultiplier * 4,
                              horizontal: SizeConfig.widthMultiplier * 4),
                          child: Row(children: [
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
                            Expanded(flex: 3, child: Container()),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Text(
                                  'Contact Us ',
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.heightMultiplier * 3,
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
                              controller: Name,
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
                                hintText: 'Name',
                                hintStyle: kBodyText,
                              ),
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                color: Colors.black,
                                height: SizeConfig.heightMultiplier * 0.1875,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter a Name';
                                }
                                return null;
                              },
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
                              controller: Email,
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
                                hintText: 'Email',
                                hintStyle: kBodyText,
                              ),
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                color: Colors.black,
                                height: SizeConfig.heightMultiplier * 0.1875,
                              ),
                              validator: (value) {
                                if (value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Enter a valid email!';
                                }
                                return null;
                              },
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
                              keyboardType: TextInputType.multiline,
                              minLines: 3,
                              maxLines: 8,
                              controller: Message,
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
                                hintText: 'Message',
                                hintStyle: kBodyText,
                              ),
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                color: Colors.black,
                                height: SizeConfig.heightMultiplier * 0.1875,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter a message';
                                }
                                return null;
                              },
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
                                if (_formKey.currentState.validate()) {}
                              },
                              child: Text(
                                'Send',
                                style: TextStyle(
                                    fontSize: SizeConfig.heightMultiplier * 2.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 3.125,
                              horizontal: SizeConfig.widthMultiplier * 3.82),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: SizeConfig.widthMultiplier * 43,
                                  height: SizeConfig.heightMultiplier * 13,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[350], width: 2),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.heightMultiplier * 1.5,
                                      right: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 4,
                                          child: Image.asset(
                                            'assets/images/mail.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            child: Text(
                                              'support@suitify.com',
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      2,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Expanded(flex: 1, child: Container()),
                                      ],
                                    ),
                                  )),
                              Container(
                                  width: SizeConfig.widthMultiplier * 43,
                                  height: SizeConfig.heightMultiplier * 13,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[350], width: 2),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.heightMultiplier * 1.5,
                                      right: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 4,
                                          child: Image.asset(
                                            'assets/images/phone.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            child: Text(
                                              '+91 1234567890',
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      2,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Expanded(flex: 1, child: Container()),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
              ))));
    });
  }
}
