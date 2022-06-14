import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_job_details-1.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class CandidateViewRecruiter extends StatelessWidget {
  final int id;
  final String designation;
  final String experience;
  final String salary;
  final String location;
  final String imageUrl;
  final String companyName;
  final String jobdetails;
  final String skills;
  final DateTime jobposting;
  CandidateViewRecruiter(
      {Key key,
      this.id,
      this.designation,
      this.experience,
      this.salary,
      this.location,
      this.imageUrl,
      this.companyName,
      this.jobdetails,
      this.skills,
      this.jobposting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.heightMultiplier * 2.25,
            right: SizeConfig.heightMultiplier * 2.25,
            bottom: SizeConfig.heightMultiplier * 1.15),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 1,
            child: Container(
                height: SizeConfig.heightMultiplier * 12,
                child: Padding(
                    padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                child: Text(designation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.4,
                                    )),
                              ),
                              FittedBox(
                                child: Text('$experience years',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.2,
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            height: SizeConfig.heightMultiplier * 5,
                            width: SizeConfig.widthMultiplier * 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: kBlue,
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => cJob1(
                                            companyName: companyName,
                                            designation: designation,
                                            experience: experience,
                                            id: id,
                                            salary: salary,
                                            location: location,
                                            imageUrl: imageUrl,
                                            jobdetails: jobdetails,
                                            skills: skills,
                                            jobposting: jobposting)));
                              },
                              child: Text(
                                'View',
                                style: TextStyle(
                                    fontSize: SizeConfig.heightMultiplier * 2.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ])))));
  }
}
