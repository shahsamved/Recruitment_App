import 'package:flutter/material.dart';
import 'package:recruitment/pallete.dart';
import 'package:recruitment/screens/Old UI/home_page.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home_Page()));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        height: size.height * 0.15,
        //padding: const EdgeInsets.all(15),
        child: Image.asset("assets/images/logo.png", fit: BoxFit.fitHeight),
      ),
    );
  }
}
