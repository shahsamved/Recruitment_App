import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_recruiter_details.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class CandidateMainRecruiters extends StatelessWidget {
  final int id;
  final String companyName;
  final String location;

  final String imageUrl;

  CandidateMainRecruiters(
    this.id,
    this.companyName,
    this.location,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    // DateTime time1 = jobPosting.toLocal();
    // var text = 'Posted on ${time1.day}/${time1.month}';
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.heightMultiplier * 2.25,
          right: SizeConfig.heightMultiplier * 2.25,
          bottom: SizeConfig.heightMultiplier * 1.15),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => cRecruit(
                    id: id,
                    imageUrl: imageUrl,
                    companyName: companyName,
                    location: location))),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: Container(
            height: SizeConfig.heightMultiplier * 12.8,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          imageUrl,
                          height: SizeConfig.heightMultiplier * 5.75,
                          fit: BoxFit.fitHeight,
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
                              Text(companyName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2.4,
                                      color: Color(0xff242E42))),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 0.7),
                                child: Text(location,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
