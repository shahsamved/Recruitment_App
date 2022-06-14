import 'package:flutter/material.dart';
import 'package:recruitment/screens/Old UI/candidate_register.dart';
import 'package:recruitment/screens/Old UI/screens.dart';
import 'package:recruitment/widgets/Old widgets/logo.dart';

import '/pallete.dart';

class Home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget title = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
              decoration: BoxDecoration(
                color: kBlue,
                border: Border.all(
                  color: kBlue,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: const Text(
                    'We Are Looking For',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )))
        ],
      ),
    );

    Widget secondbar = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Expanded(
          Text(
            'Jobs',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: kBlue, fontSize: 18),
          ),

          //),
          Text(
            'Candidates',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: kBlue, fontSize: 18),
          ),
        ],
      ),
    );

    Widget box = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(children: [
                          Text(
                            '\"Some 1.9 Crore salaried',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'been lost after the lockdown,',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'estimates the CMIE',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'A separate report by the',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'International Labour',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'Organisation (ILO) and the ',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'Asian Development Bank',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '(ADB) estimates that more',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'than 40 Lacs Indians below',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'the age of 30 have their',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'jobs due to pandemic.\"',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '-BBC News',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.red,
                            ),
                          ),
                        ])
                      ])))
        ],
      ),
    );

    Widget text1 = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Text(
                  'We are building a strong',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'community of',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
              ])
            ]));

    Widget text2 = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JOB SEEKERS & RECRUITERS',
              maxLines: 2,
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));

    Widget text3 = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Text(
                  'to help those who have lost',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'their JOBS due to PANDEMIC',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
              ])
            ]));

    Widget button = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 70,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kBlue),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Register_option()));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ));

    Widget text4 = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Text(
                  'here if you are looking for',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'JOB or CANDIDATE',
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ])
            ]));

    Widget text5 = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Text(
                  'Note: Priority will be given to those who have lost',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'their job',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ])
            ]));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Logo(),
          title,
          secondbar,
          box,
          text1,
          text2,
          text3,
          button,
          text4,
          text5
        ]),
      ),
    );
  }
}
