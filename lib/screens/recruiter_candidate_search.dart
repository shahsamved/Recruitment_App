import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_view_recruiters.dart';
import 'package:recruitment/provider/r_candidate_search.dart';
import 'package:recruitment/size_config.dart';
import 'package:recruitment/widgets/candidate_view_recruiter.dart';
import 'package:recruitment/widgets/recruiter_c_search.dart';
import '../pallete.dart';

class RecruiterCandidateSearch extends StatefulWidget {
  @override
  _RecruiterCandidateSearchState createState() =>
      _RecruiterCandidateSearchState();
}

class _RecruiterCandidateSearchState extends State<RecruiterCandidateSearch> {
  @override
  Widget build(BuildContext context) {
    final rcp = Provider.of<RCandidateSearchP>(context);

    return Scaffold(
        backgroundColor: kGrey,
        body: SafeArea(
            bottom: false,
            left: true,
            right: true,
            top: true,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 1.2,
                    left: SizeConfig.heightMultiplier * 2,
                    right: SizeConfig.heightMultiplier * 2),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'assets/images/black-arrow.png',
                        height: SizeConfig.heightMultiplier * 1.65,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 10,
                    child: FittedBox(
                      child: Text(
                        'Candidate Search Result',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 2.7),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                ]),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 2.25,
                  ),
                  child: Container(
                      child: Padding(
                          padding:
                              EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: rcp.items.length,
                                  // physics: NeverScrollableScrollPhysics(),
                                  //padding: EdgeInsets.zero,
                                  itemBuilder: (ctx, i) => RecruiterCSearch(
                                      rcp.items[i].id,
                                      rcp.items[i].name,
                                      rcp.items[i].experience,
                                      rcp.items[i].location,
                                      rcp.items[i].imageURL),
                                ),
                              ]))))
            ]))));
  }
}
