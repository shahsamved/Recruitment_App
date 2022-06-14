import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_home_jobs.dart';
import 'package:recruitment/provider/c_home_recruiters.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/menu.dart';
import 'package:recruitment/size_config.dart';
import 'package:recruitment/widgets/candidateMainRecruiters.dart';
import '../pallete.dart';
import '../widgets/candidateMainJobs.dart';

class CandidateHomePage extends StatefulWidget {
  @override
  _CandidateHomePageState createState() => _CandidateHomePageState();
}

class _CandidateHomePageState extends State<CandidateHomePage> {
  bool _hasBeenPressed = true;
  bool isLoading = false;
  bool initial = true;
  bool iserror = false;
  bool isLoading2 = false;
  bool initial2 = true;
  bool iserror2 = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (initial) {
      setState(() {
        isLoading = true;
      });

      Provider.of<CHomeJobsP>(context, listen: true)
          .fetchJobPos()
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
    if (initial2) {
      setState(() {
        isLoading2 = true;
      });
      Provider.of<CHomeRecruitersP>(context, listen: true)
          .fetchRecruiters()
          .then((value) {
        setState(() {
          isLoading2 = false;
        });
        initial2 = false;
      }).catchError((onerror) {
        print("error is");
        setState(() {
          isLoading2 = false;
        });

        const errorMessage = 'Something went wrong. Please try again later';
        showAlertDialog(context);
        print(errorMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homePageData = Provider.of<CHomeJobsP>(context);
    final homePageDataR = Provider.of<CHomeRecruitersP>(context);
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          backgroundColor: kGrey,
          drawer: Menu(),
          body: SafeArea(
              bottom: false,
              left: true,
              right: true,
              top: false,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
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
                                child: Text(
                                  'Jobs',
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
                                child: Text(
                                  'Recruiters',
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
                                          ' Job positions available',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  2.15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff1A171D))),
                                  Image.asset(
                                    'assets/images/filter_grid.png',
                                    height: SizeConfig.heightMultiplier * 2.15,
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
                                  Text(
                                      homePageDataR.items.length.toString() +
                                          ' Recruiters available',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  2.15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff1A171D))),
                                  Image.asset(
                                    'assets/images/filter_grid.png',
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
                              itemBuilder: (ctx, i) => CandidateMainJobs(
                                    homePageData.items[i].id,
                                    homePageData.items[i].companyName,
                                    homePageData.items[i].location,
                                    homePageData.items[i].jobPosting,
                                    homePageData.items[i].imageUrl,
                                    homePageData.items[i].designation,
                                    homePageData.items[i].salary,
                                    homePageData.items[i].experience,
                                    homePageData.items[i].jobdetails,
                                    homePageData.items[i].skills,
                                  )),
                        )
                      : Expanded(
                          flex: 12,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: homePageDataR.items.length,
                              itemBuilder: (ctx, i) => CandidateMainRecruiters(
                                    homePageDataR.items[i].id,
                                    homePageDataR.items[i].companyName,
                                    homePageDataR.items[i].location,
                                    homePageDataR.items[i].imageUrl,
                                  )),
                        )
                ],
              )));
    });
  }
}

class TopContainerPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: SizeConfig.heightMultiplier * 0.122,
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
              //Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 5,
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
    content: Text("Failed to view Jobs. Try Again"),
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
