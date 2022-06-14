import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/model/ProgressHUD.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_charges.dart';
import 'package:recruitment/screens/recruiter_charges.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'candidate_login.dart';
import 'package:image_picker/image_picker.dart';

class RecruiterCompleteProfile extends StatefulWidget {
  @override
  _RecruiterCompleteProfileState createState() =>
      _RecruiterCompleteProfileState();
}

class City {
  int id;
  String name;

  City(this.id, this.name);

  static List<City> getCities() {
    return <City>[
      City(1, 'New York'),
      City(2, 'LA'),
      City(3, 'Florida'),
      City(4, 'Boson'),
      City(5, 'Texas'),
    ];
  }
}

class States {
  int id;
  String name;

  States(this.id, this.name);

  static List<States> getStates() {
    return <States>[
      States(1, 'New York'),
      States(2, 'LA'),
      States(3, 'Florida'),
      States(4, 'Boson'),
      States(5, 'Texas'),
    ];
  }
}

class Industry {
  int id;
  String name;

  Industry(this.id, this.name);

  static List<Industry> getIndustries() {
    return <Industry>[
      Industry(1, 'Technology'),
      Industry(2, 'Healthcare'),
      Industry(3, 'Designing'),
      Industry(4, 'Marketing'),
      Industry(5, 'Law'),
    ];
  }
}

class _RecruiterCompleteProfileState extends State<RecruiterCompleteProfile> {
  File _image = null;
  String filepath = "";
  bool _isDrop = false;
  bool _isDrop2 = false;
  bool _isDrop3 = false;
  var _formKey = GlobalKey<FormState>();

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
    });
  }

  bool isLoad = false;
  bool isInitial;
  var _isLoading = false;

  Map<String, String> _rData = {
    'Contact_Person': '',
    'City': '',
    'State': '',
    'Industry': ''
  };

  Future<void> _submit() async {
    //_image != null ? photo = _image : null;
    _rData['Industry'] = '${_selectedIndustry.name}';
    _rData['City'] = '${_selectedCity.name}';
    _rData['State'] = '${_selectedState.name}';
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).rcomplete_profile(
        _rData['Contact_Person'],
        _rData['City'],
        _rData['State'],
        _rData['Industry'],
      );
      print("here");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RecruiterCharges()));
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

  @override
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
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
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
                                flex: 1,
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
                                      child: FittedBox(
                                        child: Text(
                                          "Almost Done! Complete Your Profile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.2),
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'This field cannot be empty';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _rData['Contact_Person'] = (value);
                                            print(_rData['Contact_Person']);
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
                                              hintText: 'Contact Person',
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
                                          keyboardType: TextInputType.text,
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  _isDrop
                                                      ? Text(
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
                                                      : Text(
                                                          'City',
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
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        270,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    //value: _selectedCity,
                                                    items: _dropdownMenuItems,
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  _isDrop2
                                                      ? Text(
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
                                                      : Text(
                                                          'State',
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
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        270,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    //value: _selectedCity,
                                                    items: _dropdownMenuItems2,
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  _isDrop3
                                                      ? Text(
                                                          '${_selectedIndustry.name}',
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
                                                      : Text(
                                                          'Industry',
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
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        270,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    //value: _selectedCity,
                                                    items: _dropdownMenuItems3,
                                                    onChanged:
                                                        onChangeDropdownItem3,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.widthMultiplier * 3.82,
                                          right:
                                              SizeConfig.widthMultiplier * 3.82,
                                          top: SizeConfig.widthMultiplier *
                                              30.82),
                                      child: Container(
                                        height: SizeConfig.heightMultiplier * 7,
                                        width: SizeConfig.widthMultiplier * 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: kBlue,
                                        ),
                                        child: FlatButton(
                                          onPressed: () {
                                            _submit();
                                          },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .heightMultiplier *
                                                    2.5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //     flex: 1,
                              //     child: Container(
                              //       color: Colors.greenAccent,
                              //     ))
                            ]),
                      ))))));
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
    content: Text("Failed to Update profile. Try Again"),
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
