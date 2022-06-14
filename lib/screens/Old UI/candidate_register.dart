import 'dart:ui';
import 'package:recruitment/pallete.dart';
import 'package:recruitment/screens/Old UI/c_otp_screen.dart';
import 'package:recruitment/screens/Old UI/login_screen.dart';
import 'package:recruitment/screens/Old UI/screens.dart';
import 'package:recruitment/widgets/Old widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _hasBeenPressed = false;
  //bool _hasBeenPressed2 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        //Logo(),
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.1,
                              backgroundColor: Colors.grey[400].withOpacity(
                                0.5,
                              ),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: kWhite,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //   top: size.height * 0.08,
                  //   left: size.width * 0.56,
                  //   child: Container(
                  //     height: size.width * 0.07,
                  //     width: size.width * 0.07,
                  //     decoration: BoxDecoration(
                  //       color: kBlue,
                  //       shape: BoxShape.circle,
                  //       border: Border.all(color: kWhite, width: 1),
                  //     ),
                  //     child: Icon(
                  //       FontAwesomeIcons.arrowUp,
                  //       color: kWhite,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.8),
                            //borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: 'Full Name',
                                hintStyle: kBodyText,
                              ),
                              style: kBodyText,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.8),
                            //borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.envelope,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: 'Email',
                                hintStyle: kBodyText,
                              ),
                              style: kBodyText,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.7,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: size.height * 0.08,
                                  child: FlatButton(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Male',
                                        style: kBodyText.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    textColor: Colors.white,
                                    color: !_hasBeenPressed
                                        ? Colors.grey[500].withOpacity(0.8)
                                        : kBlue,
                                    onPressed: () {
                                      setState(() {
                                        _hasBeenPressed = !_hasBeenPressed;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: size.height * 0.08,
                                  child: FlatButton(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Female',
                                        style: kBodyText.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    textColor: Colors.white,
                                    color: _hasBeenPressed
                                        ? Colors.grey[500].withOpacity(0.8)
                                        : kBlue,
                                    onPressed: () {
                                      setState(() {
                                        _hasBeenPressed = !_hasBeenPressed;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.8),
                            //borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.phone,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: '+91 - Mobile no.',
                                hintStyle: kBodyText,
                              ),
                              style: kBodyText,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.8),
                            //borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: kBodyText,
                              ),
                              obscureText: true,
                              style: kBodyText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.8),
                            //borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: kBodyText,
                              ),
                              obscureText: true,
                              style: kBodyText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: size.height * 0.08,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(16),
                          color: kBlue,
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (COtpScreen())));
                          },
                          child: Text(
                            'Next',
                            style:
                                kBodyText.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
