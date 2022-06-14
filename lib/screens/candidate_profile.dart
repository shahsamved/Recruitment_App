import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:recruitment/model/ProgressHUD.dart';
import 'package:recruitment/pallete.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/model/httpException.dart';
import 'package:recruitment/screens/change_password.dart';
import 'package:recruitment/screens/menu.dart';

import '../size_config.dart';

class UserProfileScreen extends StatefulWidget {
  static final String routename = '/user-profile-screen';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<FormState> _forrmkey = GlobalKey();

  Map<String, String> _userdata = {
    'name': '',
    'phone': '',
    'email': '',
  };

  Map<String, String> _previousData = {
    'name': '',
    'phone': '',
    'email': '',
  };

  int previous;
  bool iserror = false;
  bool isLoad = false;
  bool isinitial = true;

  bool _isedit = false;
  bool isPresent = false;
  var _loading = false;
  File _image = null;
  String filepath = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isinitial) {
      print("honolulu");
      final user = Provider.of<Auth>(context).getUserData();
      print(user);
      _userdata['name'] = user.name;
      _userdata['email'] = user.email;
      _userdata['phone'] = user.phone;
      _previousData['name'] = user.name;
      _previousData['email'] = user.email;
      _previousData['phone'] = user.phone;
      // _userdata['name'] = 'name';
      // _userdata['email'] = 'email@email.com';
      // _userdata['phone'] = '3333333333';
      // _previousData['name'] = 'name';
      // _previousData['email'] = 'email@email.com';
      // _previousData['phone'] = '3333333333';
      setState(() {
        //isLoad = true;
        isinitial = false;
      });
    }
  }

  Future<void> _submit() async {
    if (_isedit) {
      if (!_forrmkey.currentState.validate()) {
        return;
      }
      final Map<String, String> toUpdate = {
        'name': '',
        'phone': '',
        'email': '',
      };
      _forrmkey.currentState.save();
      setState(() {
        _loading = true;
        isLoad = true;
      });
      FocusScope.of(context).unfocus();
      if (_userdata['name'] != _previousData['name']) {
        print(_previousData['name']);
        toUpdate['name'] = _userdata['name'];
        _previousData['name'] = _userdata['name'];
      }
      if (_userdata['phone'] != _previousData['phone']) {
        toUpdate['phone'] = _userdata['phone'];
        _previousData['phone'] = _userdata['phone'];
      }
      if (_userdata['email'] != _previousData['email']) {
        toUpdate['email'] = _userdata['email'];
        _previousData['email'] = _userdata['email'];
      }

      try {
        await Provider.of<Auth>(context, listen: false)
            .updateData(toUpdate, _userdata);
        showSubmitRequestSnackBar(context, 'Changes are Successfully Saved!!');
      } on HttpException catch (error) {
        showAlertDialog(context);
        print(error.toString());
      } catch (error) {
        print("here2");
        print(error);
        showAlertDialog(context);
      }

      setState(() {
        _isedit = false;
      });
    } else {
      setState(() {
        _isedit = true;
      });
    }
    setState(() {
      _loading = false;
      isLoad = false;
    });
  }

  void showSubmitRequestSnackBar(BuildContext context, String msg) async {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      messageText: Text(msg, style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.grey[300],
      duration: Duration(seconds: 2),
    )..show(context).then((r) => Navigator.of(context));
  }

  Future<void> showChoice(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Change Profile Picture?"),
            content: Text("Which source you want to use Camera or Gallery?"),
            actions: [
              FlatButton(
                  child: Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  })
            ],
          );
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

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isLoad,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            // print("User profile page");
            // print("User profile page height is ${constraints.maxHeight}");
            // print("User profile page width is ${constraints.maxWidth}");
            var maxH =
                max(constraints.maxHeight, SizeConfig.heightMultiplier * 100);
            var maxW =
                max(constraints.maxWidth, SizeConfig.widthMultiplier * 100);
            //print(maxH);
            return Padding(
              padding: EdgeInsets.only(top: 3.95 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Container(
                    height: maxH * 0.07,
                    padding: EdgeInsets.only(
                        right: 7 * maxW / 360, left: 7 * maxW / 360),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 1.25 * SizeConfig.heightMultiplier),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (Menu()))),
                                child: Image.asset(
                                  'assets/images/black_back_arrow.png',
                                  height: SizeConfig.heightMultiplier * 1.5,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Expanded(
                            flex: 7,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier * 3),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: Icon(_isedit ? Icons.save : Icons.edit,
                                  size: 24 * maxH / 647),
                              onPressed: () {
                                _submit();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25 * maxH / 647),
                          child: InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: maxW * 0.15,
                              // size.width / 3.6,
                            ),
                            onTap: () {
                              _isedit ? showChoice(context) : print('no pic');
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20 * maxH / 647),
                            padding: EdgeInsets.only(
                                left: 20 * maxW / 360,
                                right: 20 * maxW / 360,
                                top: 10 * maxH / 647),
                            child: Form(
                              key: _forrmkey,
                              child: _isedit
                                  ? SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: maxH, maxWidth: maxW),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Name cannot be empty';
                                                    }
                                                    return null;
                                                  },
                                                  initialValue:
                                                      _userdata['name'],
                                                  onSaved: (value) {
                                                    _userdata['name'] = (value);
                                                    print(_userdata['name']);
                                                  },
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[350],
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[350],
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[350],
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      contentPadding: EdgeInsets
                                                          .all(SizeConfig
                                                                  .heightMultiplier *
                                                              1.25),
                                                      hintText: 'Full Name',
                                                      hintStyle: kBodyText),
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
                                                      TextInputType.name,
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
                                                  validator: (value) {
                                                    if (value.length != 10)
                                                      return 'Mobile Number must be of 10 digit';

                                                    return null;
                                                  },
                                                  initialValue:
                                                      _userdata['phone'],
                                                  onSaved: (value) {
                                                    _userdata['phone'] =
                                                        (value);
                                                    print(_userdata['phone']);
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
                                                  validator: (value) {
                                                    if (value.isEmpty ||
                                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                            .hasMatch(value)) {
                                                      return 'Enter a valid email!';
                                                    }
                                                    return null;
                                                  },
                                                  initialValue:
                                                      _userdata['email'],
                                                  onSaved: (value) {
                                                    _userdata['email'] =
                                                        (value);
                                                    print(_userdata['email']);
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
                                                    hintText: 'Email Address',
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
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: maxH, maxWidth: maxW),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 9,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: SizeConfig
                                                            .heightMultiplier *
                                                        1.25,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            "Name",
                                                            style: TextStyle(
                                                              fontSize: 16 *
                                                                  maxH *
                                                                  0.0016,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 15 *
                                                                          maxW /
                                                                          360),
                                                              child: Text(
                                                                //"Last Name",
                                                                (_userdata[
                                                                    'name']),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: TextStyle(
                                                                    color:
                                                                        kBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: 16 *
                                                                        maxH *
                                                                        0.0016),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: SizeConfig
                                                            .heightMultiplier *
                                                        1.25,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            "Email",
                                                            style: TextStyle(
                                                              fontSize: 16 *
                                                                  maxH *
                                                                  0.0016,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 15 *
                                                                          maxW /
                                                                          360),
                                                              child: Text(
                                                                _userdata[
                                                                    'email'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: TextStyle(
                                                                    color:
                                                                        kBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: 16 *
                                                                        maxH *
                                                                        0.0016),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: SizeConfig
                                                            .heightMultiplier *
                                                        1.25,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            "Phone Number",
                                                            style: TextStyle(
                                                              fontSize: 16 *
                                                                  maxH *
                                                                  0.0016,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 15 *
                                                                          maxW /
                                                                          360),
                                                              child: Text(
                                                                //"Phone Number",
                                                                _userdata[
                                                                    'phone'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: TextStyle(
                                                                    color:
                                                                        kBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: 16 *
                                                                        maxH *
                                                                        0.0016),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      2.125,
                                                  horizontal: SizeConfig
                                                          .widthMultiplier *
                                                      2.82),
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                (ChangePassword())));
                                                  },
                                                  child: Text(
                                                    'Change Password',
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
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
    content: Text("Failed to edit profile. Try Again"),
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
