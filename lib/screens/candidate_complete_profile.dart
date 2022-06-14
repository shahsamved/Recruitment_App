import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_charges.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'candidate_login.dart';
import 'package:image_picker/image_picker.dart';

class CandidateCompleteProfile extends StatefulWidget {
  @override
  _CandidateCompleteProfileState createState() =>
      _CandidateCompleteProfileState();
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

class _CandidateCompleteProfileState extends State<CandidateCompleteProfile> {
  // File _image = null;
  File _file = null;
  String filepath = "";
  var _formKey = GlobalKey<FormState>();
  bool _isDrop3 = false;
  String _fileName = '...';
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();

  List<Industry> _industries = Industry.getIndustries();
  List<DropdownMenuItem<Industry>> _dropdownMenuItems3;
  Industry _selectedIndustry;

  @override
  void initState() {
    _dropdownMenuItems3 = buildDropdownMenuItems3(_industries);
    _selectedIndustry = _dropdownMenuItems3[0].value;
    //_controller.addListener(() => _extension = _controller.text);
    super.initState();
  }

  void _openFileExplorer() async {
    File files = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    setState(() {
      _file = files;
      if (_file != null) {
        filepath = _file.path.split('/').last;
        print(filepath);
        print(_file);
      }
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

  Map<String, String> _userData = {
    'Education': '',
    'currentPosition': '',
    'currentIndustry': '',
    'totalWorkExperience': '',
    'lastWorkingMonth': '',
    'currentLocation': '',
    'lastDrawnSalary': ''
  };

  Future<void> _submit() async {
    //_image != null ? photo = _image : null;
    _userData['currentIndustry'] = '${_selectedIndustry.name}';
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).complete_profile(
          _userData['Education'],
          _userData['currentPosition'],
          _userData['currentIndustry'],
          _userData['totalWorkExperience'],
          _userData['lastWorkingMonth'],
          _userData['currentLocation'],
          _userData['lastDrawnSalary']);
      print("here");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CandidateCharges()));
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
  // _imgFromCamera() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     _image = image;
  //     if (_image != null) {
  //       filepath = _image.path.split('/').last;
  //       print(filepath);
  //       print(_image);
  //     }
  //   });
  // }

  // _imgFromGallery() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = image;
  //     if (_image != null) {
  //       filepath = _image.path.split('/').last;
  //       print(filepath);
  //       print(_image);
  //     }
  //   });
  // }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.file_upload_outlined),
                      title: new Text('Choose File'),
                      onTap: () {
                        _openFileExplorer();
                        print("File Explorer");
                        Navigator.of(context).pop();
                      }),
                  // new ListTile(
                  //   leading: new Icon(Icons.photo_camera),
                  //   title: new Text('Camera'),
                  //   onTap: () {
                  //     _imgFromCamera();
                  //     print("camera");
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              ),
            ),
          );
        });
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
                                flex: 3,
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
                                            _userData['Education'] = (value);
                                            print(_userData['Education']);
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
                                              hintText: 'Education',
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
                                            _userData['currentPosition'] =
                                                (value);
                                            print(_userData['currentPosition']);
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
                                              hintText: 'Current Position',
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
                                                          'Current Industry',
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
                                            _userData['totalWorkExperience'] =
                                                (value);
                                            print(_userData[
                                                'totalWorkExperience']);
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
                                              hintText: 'Total Work Experience',
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
                                            _userData['lastWorkingMonth'] =
                                                (value);
                                            print(
                                                _userData['lastWorkingMonth']);
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
                                              hintText: 'Last Working Month',
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
                                            _userData['currentLocation'] =
                                                (value);
                                            print(_userData['currentLocation']);
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
                                              hintText: 'Current Location',
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
                                            _userData['lastDrawnSalary'] =
                                                (value);
                                            print(_userData['lastDrawnSalary']);
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
                                              hintText: 'Last Drawn salary',
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
                                          keyboardType: TextInputType.number,
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
                                                    7,
                                                left: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              child: _file != null
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
                                                          'Upload Resume',
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
                                                  3.125,
                                          horizontal:
                                              SizeConfig.widthMultiplier *
                                                  3.82),
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
                                            // if (_formKey.currentState
                                            //     .validate()) {

                                            //}
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
    content: Text("Failed to add details. Try again later"),
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
