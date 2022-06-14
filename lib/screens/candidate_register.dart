import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/model/ProgressHUD.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/otp_screen.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recruitment/screens/candidate_complete_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../pallete.dart';
import 'candidate_login.dart';

// ignore: camel_case_types
class C_Register extends StatefulWidget {
  static const routeName = "/register";
  @override
  _C_RegisterState createState() => _C_RegisterState();
}

// ignore: camel_case_types
class _C_RegisterState extends State<C_Register> {
  bool _hasBeenPressed = true;
  File _image = null;
  String filepath = "";
  var _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoad = false;
  bool isInitial;
  var _isLoading = false;

  Map<String, String> _userData = {
    'name': '',
    'phone': '',
    'gender': '',
    'email': '',
    'password': '',
  };

  Future<void> _submit() async {
    _hasBeenPressed ? _userData['gender'] = 'M' : _userData['gender'] = 'F';
    //_image != null ? photo = _image : null;
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).register(
          _userData['name'],
          _userData['phone'],
          _userData['email'],
          _userData['password'],
          _userData['gender']);
      print("here");
      Navigator.of(context).pushNamed(OtpScreen.routeName, arguments: {
        'phone': _userData['phone'],
        'from': C_Register.routeName
      });
    } on HttpException catch (error) {
      print("here1");
      //print(error.toString());
      showAlertDialog(context);
    } catch (error) {
      print("here2");
      print(error);
      showAlertDialog(context);
      const errorMessage = 'Could not authenticate you. Please try again later';
      print(errorMessage);
    }

    setState(() {
      _isLoading = false;
      isLoad = false;
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
      if (_image != null) {
        filepath = _image.path.split('/').last;
        print(filepath);
        print(_image);
      }
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
      if (_image != null) {
        filepath = _image.path.split('/').last;
        print(filepath);
        print(_image);
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        print("gallary");
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      print("camera");
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
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
      TextEditingController password = TextEditingController();
      TextEditingController confirmpassword = TextEditingController();
      return Scaffold(
          key: _scaffoldKey,
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
                            flex: 4,
                            child: Column(children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 1.25 * SizeConfig.heightMultiplier),
                                  child: Container(
                                    child: Text(
                                      "Candidate Registration",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.textMultiplier * 3),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    child: Row(
                                  children: [
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color: _hasBeenPressed
                                                            ? kBlue
                                                            : Colors.grey[350],
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/male.png',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          10.0,
                                                      width: SizeConfig
                                                              .heightMultiplier *
                                                          15.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    {
                                                      setState(() {
                                                        _hasBeenPressed = true;
                                                      });
                                                    }
                                                  }),
                                              SizedBox(
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1),
                                              Text(
                                                "Male",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.2),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color: _hasBeenPressed
                                                            ? Colors.grey[350]
                                                            : kBlue,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/female.png',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          10.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    {
                                                      setState(() {
                                                        _hasBeenPressed = false;
                                                      });
                                                    }
                                                  }),
                                              SizedBox(
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1),
                                              Text(
                                                "Female",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.2),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                )),
                              ),
                            ]),
                          ),
                          Expanded(
                              flex: 10,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  1.25,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
                                      child: Center(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Name cannot be empty';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _userData['name'] = (value);
                                            print(_userData['name']);
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
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[350],
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[350],
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              contentPadding: EdgeInsets.all(
                                                  SizeConfig.heightMultiplier *
                                                      1.25),
                                              hintText: 'Full Name',
                                              hintStyle: kBodyText),
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                            color: Colors.black,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    0.1875,
                                          ),
                                          keyboardType: TextInputType.name,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  1.25,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
                                      child: Center(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.length != 10)
                                              return 'Mobile Number must be of 10 digit';

                                            return null;
                                          },
                                          onSaved: (value) {
                                            _userData['phone'] = (value);
                                            print(_userData['phone']);
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
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding: EdgeInsets.all(
                                                SizeConfig.heightMultiplier *
                                                    1.25),
                                            hintText: 'Mobile Number',
                                            hintStyle: kBodyText,
                                          ),
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                            color: Colors.black,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    0.1875,
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  1.25,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
                                      child: Center(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(value)) {
                                              return 'Enter a valid email!';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _userData['email'] = (value);
                                            print(_userData['email']);
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
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding: EdgeInsets.all(
                                                SizeConfig.heightMultiplier *
                                                    1.25),
                                            hintText: 'Email Address',
                                            hintStyle: kBodyText,
                                          ),
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                            color: Colors.black,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    0.1875,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  1.25,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    6.3,
                                            width: SizeConfig.widthMultiplier *
                                                300,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: SizeConfig
                                                        .heightMultiplier *
                                                    6,
                                                left: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              child: _image != null
                                                  ? FittedBox(
                                                      child: Text(
                                                        filepath,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .heightMultiplier *
                                                                2.5,
                                                            height: SizeConfig
                                                                    .heightMultiplier *
                                                                0.1875,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Upload Image',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .heightMultiplier *
                                                                  2.5,
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  0.1875,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: InkWell(
                                              onTap: () {
                                                _showPicker(context);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .heightMultiplier *
                                                        0.25,
                                                    bottom: SizeConfig
                                                            .heightMultiplier *
                                                        0.125),
                                                child: Image.asset(
                                                  'assets/images/attach.png',
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      6,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  1.25,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
                                      child: Center(
                                        child: TextFormField(
                                          controller: password,
                                          onSaved: (value) {
                                            _userData['password'] = (value);
                                            print(_userData['password']);
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
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding: EdgeInsets.all(
                                                SizeConfig.heightMultiplier *
                                                    1.25),
                                            hintText: 'Password',
                                            hintStyle: kBodyText,
                                          ),
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                            color: Colors.black,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    0.1875,
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter a password!';
                                            }
                                            return null;
                                          },
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier *
                                                  1.25,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
                                      child: Center(
                                        child: TextFormField(
                                          controller: confirmpassword,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please re-enter password';
                                            }
                                            // print(password.text);
                                            // print(confirmpassword.text);
                                            if (password.text !=
                                                confirmpassword.text) {
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
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[350],
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding: EdgeInsets.all(
                                                SizeConfig.heightMultiplier *
                                                    1.25),
                                            hintText: 'Confirm Password',
                                            hintStyle: kBodyText,
                                          ),
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                            color: Colors.black,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    0.1875,
                                          ),
                                          obscureText: true,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            SizeConfig.heightMultiplier * 1.25),
                                    child: FittedBox(
                                      child: Text(
                                        'By Signing Up & using this site,I agree to the',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'Terms & Conditions ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              //fontWeight: FontWeight.w500,
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2.2,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff1443C3)),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          'and ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.2,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          'Privacy Policy',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2.2,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff1443C3)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeConfig.heightMultiplier * 3.125,
                                        horizontal:
                                            SizeConfig.widthMultiplier * 3.82),
                                    child: Container(
                                      height: SizeConfig.heightMultiplier * 7,
                                      width: SizeConfig.widthMultiplier * 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: kBlue,
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          // if (_formKey.currentState
                                          //     .validate()) {
                                          // // Navigator.push(
                                          // //     context,
                                          // //     MaterialPageRoute(
                                          // //         builder: (context) =>
                                          // //             OtpScreen()));
                                          // }
                                          _submit();
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //       bottom:
                                  //           SizeConfig.heightMultiplier * 1.25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'Already have an account? ',
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
                                            'Sign In',
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
                                                        CLogin()));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ))));
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
                                Navigator.of(context).pop();
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
    content: Text("Failed to Sign-up. Try Again"),
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
