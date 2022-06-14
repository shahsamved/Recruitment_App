import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:recruitment/pallete.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/model/httpException.dart';
import 'package:recruitment/screens/recruiter_change_password.dart';

import '../size_config.dart';
import 'recruiter_complete_profile.dart';

class RecruiterProfileScreen extends StatefulWidget {
  @override
  _RecruiterProfileScreenState createState() => _RecruiterProfileScreenState();
}

class _RecruiterProfileScreenState extends State<RecruiterProfileScreen> {
  final GlobalKey<FormState> _forrmkey = GlobalKey();
  bool _isDrop = false;
  bool _isDrop2 = false;
  bool _isDrop3 = false;

  List<City> _cities = City.getCities();
  List<DropdownMenuItem<City>> _dropdownMenuItems;
  City _selectedCity;

  List<States> _states = States.getStates();
  List<DropdownMenuItem<States>> _dropdownMenuItems2;
  States _selectedState;

  List<Industry> _industries = Industry.getIndustries();
  List<DropdownMenuItem<Industry>> _dropdownMenuItems3;
  Industry _selectedIndustry;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_cities);
    _selectedCity = _dropdownMenuItems[0].value;
    _dropdownMenuItems2 = buildDropdownMenuItems2(_states);
    _selectedState = _dropdownMenuItems2[0].value;
    _dropdownMenuItems3 = buildDropdownMenuItems3(_industries);
    _selectedIndustry = _dropdownMenuItems3[0].value;
    super.initState();
  }

  List<DropdownMenuItem<City>> buildDropdownMenuItems(List cities) {
    List<DropdownMenuItem<City>> items = List();
    for (City city in cities) {
      items.add(
        DropdownMenuItem(
          value: city,
          child: Text(city.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(City selectedCity) {
    setState(() {
      _selectedCity = selectedCity;

      _userdata['city'] = '${_selectedCity.name}';
      print(_userdata['city']);

      _isDrop = true;
    });
  }

  List<DropdownMenuItem<States>> buildDropdownMenuItems2(List states) {
    List<DropdownMenuItem<States>> items = List();
    for (States state in states) {
      items.add(
        DropdownMenuItem(
          value: state,
          child: Text(state.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem2(States selectedState) {
    setState(() {
      _selectedState = selectedState;
      _isDrop2 = true;
      _userdata['state'] = '${_selectedState.name}';
      print(_userdata['state']);
    });
  }

  List<DropdownMenuItem<Industry>> buildDropdownMenuItems3(List industries) {
    List<DropdownMenuItem<Industry>> items = List();
    for (Industry industry in industries) {
      items.add(
        DropdownMenuItem(
          value: industry,
          child: Text(industry.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem3(Industry selectedIndustry) {
    setState(() {
      _selectedIndustry = selectedIndustry;
      _isDrop3 = true;
      _userdata['industry'] = '${_selectedIndustry.name}';
      print(_userdata['industry']);
    });
  }

  Map<String, String> _userdata = {
    'name': '',
    'phone': '',
    'email': '',
    'city': '',
    'state': '',
    'industry': ''
  };

  Map<String, String> _previousData = {
    'name': '',
    'phone': '',
    'email': '',
    'city': '',
    'state': '',
    'industry': ''
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
  List<City> cityAvailable = [];
  String cityselected;
  int cityid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isinitial) {
      _userdata['name'] = 'Deadpool';
      _userdata['email'] = 'dp@dp.com';
      _userdata['phone'] = '0070070070';
      _userdata['city'] = '${_selectedCity.name}';
      _userdata['state'] = '${_selectedState.name}';
      _userdata['industry'] = '${_selectedIndustry.name}';
      _previousData['name'] = 'Deadpool';
      _previousData['email'] = 'dp@dp.com';
      _previousData['phone'] = '0070070070';
      _previousData['city'] = '${_selectedCity.name}';
      _previousData['state'] = '${_selectedState.name}';
      _previousData['industry'] = '${_selectedIndustry.name}';
      setState(() {
        isLoad = true;
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
        'city': '',
        'state': '',
        'industry': ''
      };
      _forrmkey.currentState.save();
      setState(() {
        _loading = true;
      });
      FocusScope.of(context).unfocus();
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
                                onTap: () => Navigator.of(context).pop(),
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
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      1.25,
                                                  horizontal: SizeConfig
                                                          .widthMultiplier *
                                                      3.82),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        6.3,
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
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
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${_selectedCity.name}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .heightMultiplier *
                                                                  2.5,
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  0.1875,
                                                              //color: Colors.grey
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .widthMultiplier *
                                                              3.82,
                                                          right: SizeConfig
                                                                  .widthMultiplier *
                                                              3.82),
                                                      child: Container(
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            270,
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton(
                                                            //value: _selectedCity,
                                                            items:
                                                                _dropdownMenuItems,
                                                            onChanged:
                                                                onChangeDropdownItem,
                                                          ),
                                                        ),
                                                      ))
                                                ],
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
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        6.3,
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
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
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${_selectedState.name}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .heightMultiplier *
                                                                  2.5,
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  0.1875,
                                                              //color: Colors.grey
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .widthMultiplier *
                                                              3.82,
                                                          right: SizeConfig
                                                                  .widthMultiplier *
                                                              3.82),
                                                      child: Container(
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            270,
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton(
                                                            //value: _selectedCity,
                                                            items:
                                                                _dropdownMenuItems2,
                                                            onChanged:
                                                                onChangeDropdownItem2,
                                                          ),
                                                        ),
                                                      ))
                                                ],
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
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        6.3,
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey[350],
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
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
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              '${_selectedIndustry.name}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .heightMultiplier *
                                                                    2.5,
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    0.1875,
                                                                //color: Colors.grey
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .widthMultiplier *
                                                              3.82,
                                                          right: SizeConfig
                                                                  .widthMultiplier *
                                                              3.82),
                                                      child: Container(
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            270,
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton(
                                                            //value: _selectedCity,
                                                            items:
                                                                _dropdownMenuItems3,
                                                            onChanged:
                                                                onChangeDropdownItem3,
                                                          ),
                                                        ),
                                                      ))
                                                ],
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
                                                            "City",
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
                                                                    'city']),
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
                                                            "State",
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
                                                                    'state']),
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
                                                            "Industry",
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
                                                                    'industry']),
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
                                                                (RChangePassword())));
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
