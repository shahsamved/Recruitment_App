import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:recruitment/size_config.dart';

import '../pallete.dart';

class RecruiterCSearch extends StatelessWidget {
  final int id;
  final String name;
  final String experience;
  final String location;
  final String imageURL;

  RecruiterCSearch(
      this.id, this.name, this.experience, this.location, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.heightMultiplier * 0.5,
            right: SizeConfig.heightMultiplier * 0.5,
            bottom: SizeConfig.heightMultiplier * 1.15),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 1,
            child: Container(
                height: SizeConfig.heightMultiplier * 21.5,
                child: Padding(
                    padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Image.network(imageURL, fit: BoxFit.cover),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.4,
                                            color: Color(0xff242E42))),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.heightMultiplier *
                                              0.7),
                                      child: Text("Exp: $experience",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2,
                                              color: kGrey2)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.heightMultiplier *
                                              0.7),
                                      child: Text(location,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2,
                                              color: kGrey2)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 1.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: SizeConfig.heightMultiplier * 5,
                                width: SizeConfig.widthMultiplier * 33,
                                decoration: BoxDecoration(
                                  color: Color(0xffE1EAFF),
                                  border: Border.all(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Text('Contact',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2.1,
                                          color: kBlue)),
                                ),
                              ),
                              Container(
                                height: SizeConfig.heightMultiplier * 5,
                                width: SizeConfig.widthMultiplier * 33,
                                decoration: BoxDecoration(
                                  color: Color(0xffE1EAFF),
                                  border: Border.all(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Text('Send Job',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2.1,
                                          color: kBlue)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )))));
  }
}
