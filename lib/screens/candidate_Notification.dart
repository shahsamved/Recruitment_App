import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/menu.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/notification.dart' as nt;
import '../pallete.dart';

class CandidateNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationData = Provider.of<CandidateNotificationP>(context);
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        bottom: false,
        left: true,
        right: true,
        top: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 8.5,
              ),
              child: Row(children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => (Menu())));
                      },
                      child: Image.asset(
                        'assets/images/black-arrow.png',
                        width: SizeConfig.heightMultiplier * 1.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 6, child: Container()),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        'Notification',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.heightMultiplier * 3,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 8, child: Container()),
              ]),
            ),
            Expanded(
              flex: 12,
              child: ListView.builder(
                  itemCount: notificationData.items.length,
                  itemBuilder: (ctx, i) => nt.Notification(
                      notificationData.items[i].id,
                      notificationData.items[i].type,
                      notificationData.items[i].message,
                      notificationData.items[i].time,
                      notificationData.items[i].imageUrl)),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  'assets/images/purple_cross.png',
                  width: SizeConfig.heightMultiplier * 8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
