import 'package:flutter/material.dart';
import 'package:recruitment/pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    //required Key key,
    @required this.buttonName,
  });

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
