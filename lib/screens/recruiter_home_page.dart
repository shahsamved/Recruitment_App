import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/model/httpException.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/provider/r_home_open_positions.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/menu.dart';
import 'package:recruitment/screens/recruiter_menu.dart';
import 'package:recruitment/size_config.dart';
import '../pallete.dart';
import '../widgets/recruiter_home_open_jobs.dart';
import 'recruiter_candidate_search.dart';

class RecruiterHomePage extends StatefulWidget {
  @override
  _RecruiterHomePageState createState() => _RecruiterHomePageState();
}

class _RecruiterHomePageState extends State<RecruiterHomePage> {
  bool _hasBeenPressed = true;
  bool isLoading = false;
  bool initial = true;
  bool iserror = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (initial) {
      setState(() {
        isLoading = true;
      });

      Provider.of<RHomeOPP>(context, listen: true).fetchJobs().then((value) {
        setState(() {
          isLoading = false;
        });
        initial = false;
      }).catchError((onerror) {
        print("error is");
        setState(() {
          isLoading = false;
        });

        const errorMessage = 'Something went wrong. Please try again later';
        showAlertDialog(context);
        print(errorMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homePageData = Provider.of<RHomeOPP>(context, listen: true);

    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          backgroundColor: kGrey,
          drawer: RMenu(),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              bottom: false,
              left: true,
              right: true,
              top: false,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        height: SizeConfig.heightMultiplier * 20,
                        child: ResponsiveWidget(
                            portraitLayout: TopContainerPortrait())),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 2,
                          bottom: SizeConfig.heightMultiplier * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _hasBeenPressed = true;
                              });
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 5.5,
                              width: SizeConfig.widthMultiplier * 42.5,
                              decoration: BoxDecoration(
                                color: _hasBeenPressed ? kBlue : kGrey,
                                border: Border.all(
                                    color: _hasBeenPressed
                                        ? kBlue
                                        : Color(0xffAAAAAA),
                                    width: 2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.heightMultiplier),
                                    child: Text(
                                      'Open Positions',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2.5,
                                          fontWeight: FontWeight.w400,
                                          color: _hasBeenPressed
                                              ? Colors.white
                                              : Color(0xffAAAAAA)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _hasBeenPressed = false;
                              });
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 5.5,
                              width: SizeConfig.widthMultiplier * 42.5,
                              decoration: BoxDecoration(
                                color: _hasBeenPressed ? kGrey : kBlue,
                                border: Border.all(
                                    color: !_hasBeenPressed
                                        ? kBlue
                                        : Color(0xffAAAAAA),
                                    width: 2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.heightMultiplier),
                                    child: Text(
                                      'Closed Positions',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2.5,
                                          fontWeight: FontWeight.w400,
                                          color: _hasBeenPressed
                                              ? Color(0xffAAAAAA)
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _hasBeenPressed
                      ? Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.heightMultiplier * 3.5,
                                right: SizeConfig.heightMultiplier * 3.2,
                                bottom: SizeConfig.heightMultiplier * 1.5),
                            child: Container(
                              height: SizeConfig.heightMultiplier * 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      homePageData.items.length.toString() +
                                          ' Jobs are opened',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  2.15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff1A171D))),
                                  Image.asset(
                                    'assets/images/filter_funnel.png',
                                    height: SizeConfig.heightMultiplier * 2.4,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.heightMultiplier * 3.5,
                                right: SizeConfig.heightMultiplier * 3.2,
                                bottom: SizeConfig.heightMultiplier * 1.5),
                            child: Container(
                              height: SizeConfig.heightMultiplier * 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0 Jobs are closed',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  2.15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff1A171D))),
                                  Image.asset(
                                    'assets/images/filter_funnel.png',
                                    height: SizeConfig.heightMultiplier * 2.15,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  _hasBeenPressed
                      ? Expanded(
                          flex: 12,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: homePageData.items.length,
                              itemBuilder: (ctx, i) => RecruiterMainOP(
                                    homePageData.items[i].id,
                                    homePageData.items[i].companyName,
                                    homePageData.items[i].location,
                                    homePageData.items[i].designation,
                                    homePageData.items[i].experience,
                                    homePageData.items[i].vacancies,
                                  )),
                        )
                      : Expanded(
                          flex: 12,
                          child: Container(
                              child: Center(
                                  child: Text(
                            'Closed Jobs',
                            style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5),
                          ))),
                        ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: kWhite,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2,
                            bottom: SizeConfig.heightMultiplier * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 44,
                              decoration: BoxDecoration(
                                color: kBlue,
                                // border: Border.all(
                                //     color: Color(0xffAAAAAA), width: 2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  _AddPosition(context);
                                },
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      'ADD POSITION',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  1.825,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 44,
                              decoration: BoxDecoration(
                                color: kBlue,
                                // border: Border.all(
                                //     color: Color(0xffAAAAAA), width: 2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  _SearchCandidate(context);
                                },
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      'SEARCH CANDIDATE',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  1.825,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )));
    });
  }

  void _AddPosition(BuildContext context) {
    bool isLoad = false;
    bool isInitial;
    var _isLoading = false;
    var _formKey = GlobalKey<FormState>();
    int vacancies = 0;
    Map<String, String> _rData = {
      'client_name': '',
      'position': '',
      'experience': '',
      'location': '',
      'job_description': '',
      'skills': '',
      'salary': '',
    };

    Future<void> _submit() async {
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
        await Provider.of<RHomeOPP>(context, listen: false).addJob(
            _rData['client_name'],
            _rData['position'],
            _rData['experience'],
            _rData['location'],
            _rData['job_description'],
            _rData['skills'],
            vacancies,
            _rData['salary']);
        print("here");
        showAlertDialog2(context);
      } on HttpException catch (error) {
        print("here1");
        print(error.toString());
        showAlertDialog(context);
      } catch (error) {
        print("here2");
        print(error);
        showAlertDialog(context);
        const errorMessage =
            'Could not authenticate you. Please try again later';
        print(errorMessage);
      }

      setState(() {
        _isLoading = false;
        isLoad = false;
      });
    }

    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5 * SizeConfig.widthMultiplier),
          topRight: Radius.circular(5 * SizeConfig.widthMultiplier),
        )),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: SizeConfig.heightMultiplier * 75,
              child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2.5,
                            left: SizeConfig.heightMultiplier * 2,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add New Position',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: Navigator.of(context).pop)
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 2.5,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['client_name'] = (value);
                                        print(_rData['client_name']);
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
                                          hintText: 'Name of client',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['position'] = (value);
                                        print(_rData['position']);
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
                                          hintText: 'Position',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['experience'] = (value);
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
                                          hintText: 'Experience',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['location'] = (value);
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
                                          hintText: 'Location',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['job_description'] = (value);
                                        print("Aa print karavu che");
                                        print(_rData['job_description']);
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
                                          hintText: 'Job Description',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      minLines: 3,
                                      maxLines: 10,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['skills'] = (value);
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
                                          hintText: 'Skills',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      minLines: 3,
                                      maxLines: 10,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 1.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        vacancies = int.parse(value);
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
                                          hintText: 'Vacancies',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 1.25,
                                      bottom:
                                          SizeConfig.heightMultiplier * 3.25,
                                      right: SizeConfig.heightMultiplier * 2),
                                  child: Center(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _rData['salary'] = (value);
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
                                          hintText: 'Salary',
                                          hintStyle: kBodyText),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2.5,
                                        color: Colors.black,
                                        height: SizeConfig.heightMultiplier *
                                            0.1875,
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: SizeConfig.heightMultiplier * 2,
                                    top: SizeConfig.widthMultiplier * 3,
                                    bottom: SizeConfig.widthMultiplier * 2.75,
                                  ),
                                  child: Container(
                                    height: SizeConfig.heightMultiplier * 7,
                                    width: SizeConfig.widthMultiplier * 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: kBlue,
                                    ),
                                    child: FlatButton(
                                      onPressed: () {
                                        _submit();
                                      },
                                      child: Text(
                                        'Next',
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
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )));
        });
  }

  void _SearchCandidate(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5 * SizeConfig.widthMultiplier),
          topRight: Radius.circular(5 * SizeConfig.widthMultiplier),
        )),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: SizeConfig.heightMultiplier * 65,
              child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2.5,
                            left: SizeConfig.heightMultiplier * 2,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search Candidate',
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: Navigator.of(context).pop)
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 1.25,
                                    bottom: SizeConfig.heightMultiplier * 1.25,
                                    right: SizeConfig.heightMultiplier * 2),
                                child: Center(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
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
                                            SizeConfig.heightMultiplier * 1.25),
                                        hintText: 'Position',
                                        hintStyle: kBodyText),
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      color: Colors.black,
                                      height:
                                          SizeConfig.heightMultiplier * 0.1875,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 1.25,
                                    bottom: SizeConfig.heightMultiplier * 1.25,
                                    right: SizeConfig.heightMultiplier * 2),
                                child: Center(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
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
                                            SizeConfig.heightMultiplier * 1.25),
                                        hintText: 'Experience',
                                        hintStyle: kBodyText),
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      color: Colors.black,
                                      height:
                                          SizeConfig.heightMultiplier * 0.1875,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 1.25,
                                    bottom: SizeConfig.heightMultiplier * 1.25,
                                    right: SizeConfig.heightMultiplier * 2),
                                child: Center(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
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
                                            SizeConfig.heightMultiplier * 1.25),
                                        hintText: 'City',
                                        hintStyle: kBodyText),
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      color: Colors.black,
                                      height:
                                          SizeConfig.heightMultiplier * 0.1875,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 1.25,
                                    bottom: SizeConfig.heightMultiplier * 1.25,
                                    right: SizeConfig.heightMultiplier * 2),
                                child: Center(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
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
                                            SizeConfig.heightMultiplier * 1.25),
                                        hintText: 'State',
                                        hintStyle: kBodyText),
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      color: Colors.black,
                                      height:
                                          SizeConfig.heightMultiplier * 0.1875,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 1.25,
                                    bottom: SizeConfig.heightMultiplier * 3.25,
                                    right: SizeConfig.heightMultiplier * 2),
                                child: Center(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
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
                                            SizeConfig.heightMultiplier * 1.25),
                                        hintText: 'Industry',
                                        hintStyle: kBodyText),
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.5,
                                      color: Colors.black,
                                      height:
                                          SizeConfig.heightMultiplier * 0.1875,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: SizeConfig.heightMultiplier * 2,
                                  top: SizeConfig.widthMultiplier * 3,
                                ),
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 7,
                                  width: SizeConfig.widthMultiplier * 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: kBlue,
                                  ),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecruiterCandidateSearch()));
                                    },
                                    child: Text(
                                      'Search',
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
                      );
                    },
                  )));
        });
  }
}

class TopContainerPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: SizeConfig.heightMultiplier * 0.118,
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
              Expanded(
                  flex: 6,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image.asset(
                                'assets/images/menu.png',
                                height: SizeConfig.heightMultiplier * 1.5,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                                child: Image.asset('assets/images/suitify2.png',
                                    height: SizeConfig.heightMultiplier * 6.5,
                                    fit: BoxFit.contain))),
                        Expanded(
                          flex: 6,
                          child: Container(),
                        ),
                        Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.search,
                              color: kWhite,
                              size: SizeConfig.heightMultiplier * 4,
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.notifications,
                              color: kWhite,
                              size: SizeConfig.heightMultiplier * 4,
                            )),
                        Expanded(flex: 1, child: Container())
                      ],
                    ),
                  )),
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
    content: Text("Failed to fetch Job Positions"),
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

showAlertDialog2(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Job Positions added successfully"),
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
