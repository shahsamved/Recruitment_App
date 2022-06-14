import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_view_recruiters.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recruitment/widgets/candidate_view_recruiter.dart';

import '../pallete.dart';
import 'Reset_password.dart';
import 'candidate_password_successful.dart';
import 'candidate_register.dart';

class cRecruit extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String companyName;
  final String location;

  const cRecruit(
      {Key key, this.id, this.imageUrl, this.companyName, this.location})
      : super(key: key);
  @override
  _cRecruitState createState() => _cRecruitState();
}

class _cRecruitState extends State<cRecruit> {
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

      Provider.of<CViewRecruitersP>(context, listen: true)
          .fetchJobs(widget.id)
          .then((value) {
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
    final cvr = Provider.of<CViewRecruitersP>(context);

    return Scaffold(
        backgroundColor: kGrey,
        body: SafeArea(
            bottom: false,
            left: true,
            right: true,
            top: true,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  bottom: SizeConfig.heightMultiplier * 0.5,
                  top: SizeConfig.heightMultiplier * 2.0),
              child: Column(children: [
                Row(children: [
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
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 9,
                    child: FittedBox(
                      child: Text(
                        'Recruiters Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 2.5),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                ]),
                Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 2.25,
                      //left: SizeConfig.heightMultiplier * 1,
                      right: SizeConfig.heightMultiplier * 2.25,
                    ),
                    child: Container(
                      child: Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          widget.imageUrl,
                                          height: SizeConfig.heightMultiplier *
                                              5.75,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Text(widget.companyName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        2.4,
                                                    color: Color(0xff242E42))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                        .heightMultiplier *
                                                    0.7),
                                            child: FittedBox(
                                              child: Text(widget.location,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2,
                                                      color: kGrey2)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 1,
                      left: SizeConfig.heightMultiplier * 2.5,
                      right: SizeConfig.heightMultiplier * 2.5,
                      bottom: SizeConfig.heightMultiplier * 2.25),
                  child: Text(
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.',
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        //backgroundColor: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.heightMultiplier * 2.1,
                        color: Color(0xff242E42)),
                    //maxLines: 7,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: cvr.items.length,
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, i) => CandidateViewRecruiter(
                    id: cvr.items[i].id,
                    designation: cvr.items[i].designation,
                    experience: cvr.items[i].experience,
                    salary: cvr.items[i].salary,
                    location: widget.location,
                    imageUrl: widget.imageUrl,
                    companyName: widget.companyName,
                    jobposting: cvr.items[i].jobposting,
                    jobdetails: cvr.items[i].jobdetails,
                    skills: cvr.items[i].skills,
                  ),
                ),
              ]),
            ))));
  }
}
