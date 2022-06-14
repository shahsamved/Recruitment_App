import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pallete.dart';

class Notification extends StatelessWidget {
  final int id;
  final String type;
  final String message;
  final DateTime time;
  final String imageUrl;
  Notification(this.id, this.type, this.message, this.time, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    DateTime time1 = time.toLocal();
    var text = '${time1.hour}:${time1.minute}';
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.heightMultiplier * 3.5,
          right: SizeConfig.heightMultiplier * 3.5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 2,
                bottom: SizeConfig.heightMultiplier * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: SizeConfig.heightMultiplier),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(type,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.heightMultiplier * 2.4,
                                    color: Color(0xff242E42))),
                            Text(text.toString(),
                                style: TextStyle(
                                    fontSize: SizeConfig.heightMultiplier * 2.2,
                                    color: Color(0xff242E42))),
                          ],
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier),
                        Text(message,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.heightMultiplier * 2.2,
                                color: Color(0xff242E42))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
