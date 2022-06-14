import 'package:flutter/material.dart';
import 'package:recruitment/screens/Old UI/candidate_register.dart';
import 'package:recruitment/screens/Old UI/recruiter_register.dart';
import 'package:recruitment/widgets/Old widgets/logo.dart';

import '/pallete.dart';

class Register_option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: size.height,
            child: Column(children: [
              Expanded(flex: 2, child: Logo()),
              Expanded(
                flex: 10,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 2, child: Container()),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: size.height * 0.08,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kBlue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Candidate',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: size.height * 0.08,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kBlue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rec_Register()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Recruiter',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Expanded(flex: 2, child: Container()),
                    ]),
              ),
              Expanded(flex: 1, child: Container())
            ])));
  }
}
