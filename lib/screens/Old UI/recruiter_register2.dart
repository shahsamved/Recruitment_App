import 'dart:ui';
import 'package:recruitment/pallete.dart';
import 'package:recruitment/widgets/Old Widgets/textfield.dart';
import 'package:recruitment/widgets/Old Widgets/widgets.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class R_Register2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Logo(),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text(
                      'Almost Done! Complete Your Profile',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
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
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'Contact Person',
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
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'City',
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
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'State',
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
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'Industry',
                              hintStyle: kBodyText,
                            ),
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(buttonName: 'Next'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
