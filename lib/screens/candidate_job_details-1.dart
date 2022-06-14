import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';
import 'Reset_password.dart';
import 'candidate_password_successful.dart';
import 'candidate_register.dart';

class cJob1 extends StatefulWidget {
  final int id;
  final String companyName;
  final String location;
  final String experience;
  final String designation;
  final String imageUrl;
  final String salary;
  final String jobdetails;
  final String skills;
  final DateTime jobposting;
  const cJob1(
      {Key key,
      this.id,
      this.companyName,
      this.location,
      this.experience,
      this.designation,
      this.imageUrl,
      this.salary,
      this.jobdetails,
      this.skills,
      this.jobposting})
      : super(key: key);

  @override
  _cJob1State createState() => _cJob1State();
}

class _cJob1State extends State<cJob1> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  bool _isFav = false;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {
        'page': JobDetails(
            experience: widget.experience,
            salary: widget.salary,
            location: widget.location,
            jobdetails: widget.jobdetails,
            skills: widget.skills,
            jobposting: widget.jobposting)
      },
      {
        'page': CompanyInfo(),
      },
      {
        'page': Reviews(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kGrey,
        body: SafeArea(
          bottom: false,
          left: true,
          right: true,
          top: true,
          // child: SingleChildScrollView(
          //   child: ConstrainedBox(
          //       constraints:
          //           BoxConstraints(minHeight: constraint.maxHeight),
          //       child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.heightMultiplier * 0.5,
                top: SizeConfig.heightMultiplier * 2.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(children: [
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
                      flex: 3,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 5,
                      child: FittedBox(
                        child: Text(
                          'Job Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 3),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share,
                                size: SizeConfig.heightMultiplier * 3))),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isFav = !_isFav;
                            });
                          },
                          icon: _isFav
                              ? Icon(Icons.star,
                                  size: SizeConfig.heightMultiplier * 3,
                                  color: Colors.amber)
                              : Icon(
                                  Icons.star_outline,
                                  size: SizeConfig.heightMultiplier * 3,
                                ),
                        )),
                  ]),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 1.25),
                      child: Container(
                          height: SizeConfig.heightMultiplier * 20,
                          width: SizeConfig.widthMultiplier * 90,
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.heightMultiplier * 1.2),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeConfig.heightMultiplier * 1.75,
                                        horizontal:
                                            SizeConfig.heightMultiplier * 1.5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    widget.designation,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConfig
                                                                .textMultiplier *
                                                            2.15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    widget.companyName,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: SizeConfig
                                                                .textMultiplier *
                                                            2.05),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.amber),
                                                    FittedBox(
                                                      child: Text(
                                                        ' 5.0 ',
                                                        style: TextStyle(
                                                            color: Colors.amber,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: SizeConfig
                                                                    .textMultiplier *
                                                                2.05),
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        '(81k Reviews)',
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .textMultiplier *
                                                                2.15),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Image.network(
                                            widget.imageUrl,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    7.75,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () => _selectPage(0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  'Job Details',
                                                  style: _selectedPageIndex == 0
                                                      ? TextStyle(
                                                          color: kBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.15)
                                                      : TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.0),
                                                ),
                                              ),
                                              Divider(
                                                color: _selectedPageIndex == 0
                                                    ? kBlue
                                                    : Colors.white,
                                                thickness: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () => _selectPage(1),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  'Company Info',
                                                  style: _selectedPageIndex == 1
                                                      ? TextStyle(
                                                          color: kBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.15)
                                                      : TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.0),
                                                ),
                                              ),
                                              Divider(
                                                color: _selectedPageIndex == 1
                                                    ? kBlue
                                                    : Colors.white,
                                                thickness: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () => _selectPage(2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  'Reviews',
                                                  style: _selectedPageIndex == 2
                                                      ? TextStyle(
                                                          color: kBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.15)
                                                      : TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.0),
                                                ),
                                              ),
                                              Divider(
                                                color: _selectedPageIndex == 2
                                                    ? kBlue
                                                    : Colors.white,
                                                thickness: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))),
                ),
                Expanded(
                  flex: 14,
                  child: _pages[_selectedPageIndex]['page'],
                  //child: Container(color: Colors.green),
                ),
              ],
            ),
          ),
          // )),
          //)
        ));
  }
}

class JobDetails extends StatelessWidget {
  final String experience;
  final String salary;
  final String location;
  final String jobdetails;
  final String skills;
  final DateTime jobposting;
  const JobDetails(
      {Key key,
      this.experience,
      this.salary,
      this.location,
      this.jobdetails,
      this.skills,
      this.jobposting})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime time1 = jobposting.toLocal();
    var text = 'Posted on ${time1.day}/${time1.month}';
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 1.25,
                              left: SizeConfig.heightMultiplier * 0.85,
                              right: SizeConfig.heightMultiplier * 0.85),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: kGrey,
                                  height: SizeConfig.heightMultiplier * 3,
                                  width: SizeConfig.widthMultiplier * 70,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.heightMultiplier * 2),
                                    child: FittedBox(
                                      child: Text('Job Description and Details',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      //top: SizeConfig.heightMultiplier * 2,
                                      left: SizeConfig.heightMultiplier * 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height:
                                              SizeConfig.heightMultiplier * 5,
                                          width:
                                              SizeConfig.heightMultiplier * 11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: kBlue,
                                          ),
                                          child: Center(
                                            child: Text('IT JOBS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                          height:
                                              SizeConfig.heightMultiplier * 5,
                                          width:
                                              SizeConfig.heightMultiplier * 17,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: kWhite,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: SizeConfig
                                                        .imageSizeMultiplier *
                                                    7,
                                              ),
                                              Center(
                                                child: FittedBox(
                                                  child: Text(text,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 11,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        // top: SizeConfig.heightMultiplier * 2,
                                        left: SizeConfig.heightMultiplier * 1.5,
                                        right: SizeConfig.heightMultiplier),
                                    child: Container(
                                      width: SizeConfig.widthMultiplier * 90,
                                      child: Card(
                                          //width: SizeConfig.widthMultiplier * 90,
                                          color: kWhite,
                                          // child: Card(
                                          //     elevation: 4,
                                          //     color: Colors.white,
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius
                                          //           .circular(SizeConfig
                                          //                   .heightMultiplier *
                                          //               1.2),
                                          //     ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              SizeConfig.heightMultiplier,
                                            ),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      jobdetails,
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .heightMultiplier *
                                                            2),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 5,
                                                              child: Container(
                                                                  height: SizeConfig
                                                                          .heightMultiplier *
                                                                      7,
                                                                  width: SizeConfig
                                                                          .heightMultiplier *
                                                                      18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .grey[300]),
                                                                    color:
                                                                        kWhite,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container()),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Icon(
                                                                            Icons
                                                                                .work_outline,
                                                                            color:
                                                                                kBlue),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container()),
                                                                      Expanded(
                                                                        flex: 6,
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              '$experience years',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container()),
                                                                    ],
                                                                  )),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container()),
                                                            Expanded(
                                                              flex: 5,
                                                              child: Container(
                                                                  height: SizeConfig
                                                                          .heightMultiplier *
                                                                      7,
                                                                  width: SizeConfig
                                                                          .heightMultiplier *
                                                                      18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .grey[300]),
                                                                    color:
                                                                        kWhite,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container()),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Icon(
                                                                            Icons
                                                                                .account_balance_wallet_outlined,
                                                                            color:
                                                                                kBlue),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container()),
                                                                      Expanded(
                                                                        flex: 6,
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              salary,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container()),
                                                                    ],
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: SizeConfig
                                                                      .heightMultiplier *
                                                                  2),
                                                          child: Container(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  7,
                                                              width: SizeConfig
                                                                      .heightMultiplier *
                                                                  29,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                                color: kWhite,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Container()),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Icon(
                                                                        Icons
                                                                            .location_on_outlined,
                                                                        color:
                                                                            kBlue),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Container()),
                                                                  Expanded(
                                                                    flex: 20,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          location,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Container()),
                                                                ],
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .heightMultiplier *
                                                            2,
                                                        // left: SizeConfig
                                                        //         .heightMultiplier *
                                                        //     2.5,
                                                        right: SizeConfig
                                                                .heightMultiplier *
                                                            2.5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        FittedBox(
                                                          child: Text('Skills',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .textMultiplier *
                                                                          2.8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        FittedBox(
                                                          child: Text(skills,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .textMultiplier *
                                                                          2.4,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 2,
                                      bottom: SizeConfig.heightMultiplier * 2,
                                      left: SizeConfig.heightMultiplier * 1.5),
                                  child: Container(
                                    height: SizeConfig.heightMultiplier * 7,
                                    width: SizeConfig.widthMultiplier * 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: kBlue,
                                    ),
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Text(
                                        'APPLY',
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
                              ),
                            ],
                          ),
                        ),
                      )))));
    });
  }
}

class CompanyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Center(
          child: Text(
        'Company Info',
      ));
    });
  }
}

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Center(
          child: Text(
        'Reviews',
      ));
    });
  }
}
