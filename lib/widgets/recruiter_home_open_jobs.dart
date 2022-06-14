import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class RecruiterMainOP extends StatelessWidget {
  final int id;
  final String companyName;
  final String location;
  final String designation;
  final String experience;
  final int vacancies;

  RecruiterMainOP(this.id, this.companyName, this.location, this.designation,
      this.experience, this.vacancies);

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
        elevation: 2,
        child: Container(
          height: SizeConfig.heightMultiplier * 18,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(designation,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.heightMultiplier * 2.4,
                            color: Color(0xff242E42))),
                    Image.asset(
                      'assets/images/share_arrow.png',
                      height: SizeConfig.heightMultiplier * 2.2,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.7),
                  child: Text(companyName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.heightMultiplier * 2.1,
                          color: kGrey2)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.7),
                  child: Text('$experience years',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.heightMultiplier * 2.1,
                          color: kGrey2)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(location,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.heightMultiplier * 2.1,
                              color: kGrey2)),
                      Container(
                        height: SizeConfig.heightMultiplier * 2.8,
                        width: SizeConfig.widthMultiplier * 10,
                        decoration: BoxDecoration(
                          color: Color(0xffE1EAFF),
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(vacancies.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.heightMultiplier * 2.1,
                                  color: kBlue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
