import "package:flutter/material.dart";
import 'package:recruitment/screens/Old UI/home_page.dart';
import 'package:recruitment/screens/Old UI/screens.dart';
import 'package:recruitment/widgets/Old widgets/logo.dart';
import 'package:otp_text_field/otp_text_field.dart';
import '/pallete.dart';

class COtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                  //color: Colors.blue,
                  child: Logo()),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'OTP VERIFICATION',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enter the OTP sent on +91-xxxxxxxxxx',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black26,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              //color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 40),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fieldWidth: MediaQuery.of(context).size.width * 0.5 / 10,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Did not receive the OTP?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Re-send OTP',
                      style: TextStyle(
                        fontSize: 28,
                        color: kBlue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: size.width * 0.5,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kBlue,
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => C_Register2()));
                          },
                          child: Text(
                            'Verify',
                            style:
                                kBodyText.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              )),
          Expanded(flex: 2, child: Container())
        ],
      ),
    );
  }
}
