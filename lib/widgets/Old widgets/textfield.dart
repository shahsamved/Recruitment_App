import 'package:flutter/material.dart';
import 'package:recruitment/pallete.dart';

class Textfield extends StatelessWidget {
  const Textfield({
    @required this.hint,
    @required this.inputType,
    @required this.inputAction,
  });

  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
              hintText: hint,
              hintStyle: kBodyText,
            ),
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}
