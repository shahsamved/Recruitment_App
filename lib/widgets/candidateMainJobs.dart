import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_job_details.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class CandidateMainJobs extends StatefulWidget {
  final int id;
  final String companyName;
  final String location;
  final String experience;
  final String designation;
  final DateTime jobPosting;
  final String imageUrl;
  final String salary;
  final String jobdetails;
  final String skills;
  CandidateMainJobs(
    this.id,
    this.companyName,
    this.location,
    this.jobPosting,
    this.imageUrl,
    this.designation,
    this.salary,
    this.experience,
    this.jobdetails,
    this.skills,
  );

  @override
  _CandidateMainJobsState createState() => _CandidateMainJobsState();
}

class _CandidateMainJobsState extends State<CandidateMainJobs> {
  bool _hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    DateTime time1 = widget.jobPosting.toLocal();
    var text = 'Posted on ${time1.day}/${time1.month}';
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.heightMultiplier * 2.25,
          right: SizeConfig.heightMultiplier * 2.25,
          bottom: SizeConfig.heightMultiplier * 1.15),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => cJob(
                    companyName: widget.companyName,
                    designation: widget.designation,
                    experience: widget.experience,
                    id: widget.id,
                    salary: widget.salary,
                    location: widget.location,
                    imageUrl: widget.imageUrl,
                    jobdetails: widget.jobdetails,
                    jobposting: widget.jobPosting,
                    skills: widget.skills))),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: Container(
            height: SizeConfig.heightMultiplier * 19,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Image.network(
                                widget.imageUrl,
                                height: SizeConfig.heightMultiplier * 5.75,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.heightMultiplier * 2,
                                right: SizeConfig.heightMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.companyName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.heightMultiplier *
                                                    2.4,
                                            color: Color(0xff242E42))),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _hasBeenPressed = !_hasBeenPressed;
                                        });
                                      },
                                      child: !_hasBeenPressed
                                          ? Icon(
                                              Icons.star_border,
                                              color: kGrey2,
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      3,
                                            )
                                          : Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      3,
                                            ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier * 0.7),
                                  child: Text(widget.location,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2,
                                          color: kGrey2)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(widget.designation,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.heightMultiplier * 2.1,
                            color: Color(0xff242E42))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.experience} years',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.1,
                                color: Color(0xff242E42))),
                        Text(text,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.1,
                                color: Color(0xff242E42))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
