import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/model/ProgressHUD.dart';
import 'package:recruitment/model/httpException.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/responsive.dart';
import 'package:recruitment/screens/candidate_home_page.dart';
import 'package:recruitment/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pallete.dart';
import 'candidate_login.dart';

class CandidateCharges extends StatefulWidget {
  @override
  _CandidateChargesState createState() => _CandidateChargesState();
}

class _CandidateChargesState extends State<CandidateCharges> {
  bool _hasBeenPressed = true;
  int val = 145;
  Razorpay razorpay;
  bool isLoad = false;
  bool isInitial;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      isLoad = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).userCharges(val);
      print("here");
      openCheckout();
    } on HttpException catch (error) {
      print("here1");
      //print(error.toString());
      showAlertDialog(context);
    } catch (error) {
      print("here2");
      print(error);
      showAlertDialog(context);
      const errorMessage = 'Could not authenticate you. Please try again later';
      print(errorMessage);
    }

    setState(() {
      _isLoading = false;
      isLoad = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_c2DnKMGi7febB4",
      "amount": val * 100,
      "name": "Payment Method",
      "description": "Payment for your subscription",
      "prefill": {"contact": "9876543210", "email": "temp@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      },
      "theme": {"color": "#1443C3"}
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print('Error');
      //print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CandidateHomePage()));
    print("Payment success");
    Fluttertoast.showToast(
        msg: "Payment successfully made " + response.paymentId);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Fluttertoast.showToast(
        msg: "Payment error" +
            response.code.toString() +
            '-' +
            response.message);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(msg: "External Wallet" + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isLoad,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          backgroundColor: kGrey,
          body: SafeArea(
              bottom: false,
              left: true,
              right: true,
              top: false,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 30,
                              child: ResponsiveWidget(
                                portraitLayout: TopContainerPortrait(),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    1.25),
                                        // horizontal:
                                        //     SizeConfig.widthMultiplier * 3.82),
                                        child: FittedBox(
                                          child: Text(
                                            "Charges",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.75),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.heightMultiplier * 1.25),
                                        child: FittedBox(
                                          child: Text(
                                            "We charge a nominal Registration & Processing\nfees to help you reach Recruiters and apply to\nJobs posted by recruiters.",
                                            style: TextStyle(
                                                //fontWeight: FontWeight.w500,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.2),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    1.25),
                                        // horizontal:
                                        //     SizeConfig.widthMultiplier * 3.82),
                                        child: FittedBox(
                                          child: Text(
                                            "Why we Charge?",
                                            style: TextStyle(
                                                color: kBlue,
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.2),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    0.75,
                                            horizontal:
                                                SizeConfig.widthMultiplier *
                                                    20.82),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              {
                                                setState(() {
                                                  val = 145;
                                                  _hasBeenPressed = true;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      14.375,
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      101.53,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: _hasBeenPressed
                                                      ? kBlue
                                                      : Colors.grey[350],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: SizeConfig
                                                                .heightMultiplier *
                                                            1),
                                                    child: FittedBox(
                                                      child: Text(
                                                        "Rs. 145",
                                                        style: TextStyle(
                                                            color: kBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: SizeConfig
                                                                    .textMultiplier *
                                                                4.5),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      "For Monthly",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.2),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    0.75,
                                            horizontal:
                                                SizeConfig.widthMultiplier *
                                                    20.82),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              {
                                                setState(() {
                                                  val = 1200;
                                                  _hasBeenPressed = false;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      14.375,
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      101.53,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: _hasBeenPressed
                                                      ? Colors.grey[350]
                                                      : kBlue,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: SizeConfig
                                                                .heightMultiplier *
                                                            1),
                                                    child: FittedBox(
                                                      child: Text(
                                                        "Rs. 1200",
                                                        style: TextStyle(
                                                            color: kBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: SizeConfig
                                                                    .textMultiplier *
                                                                4.5),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      "For Yearly",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.2),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    4.25,
                                            horizontal:
                                                SizeConfig.widthMultiplier *
                                                    7.82),
                                        child: Container(
                                          height:
                                              SizeConfig.heightMultiplier * 7,
                                          width:
                                              SizeConfig.widthMultiplier * 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: kBlue,
                                          ),
                                          child: FlatButton(
                                            onPressed: () {
                                              _submit();
                                            },
                                            child: FittedBox(
                                              child: Text(
                                                'Pay Now & Get Started',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        2.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])),
                          ]))))));
    });
  }
}

class TopContainerPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: SizeConfig.heightMultiplier * 0.1175,
      alignment: Alignment.topCenter,
      child: Container(
          padding: EdgeInsets.only(top: 3.0 * SizeConfig.heightMultiplier),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
            color: Color(0xff1443C3),
          ),
          child: Column(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                'assets/images/back-arrow.png',
                                height: SizeConfig.heightMultiplier * 1.5,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                      child: Image.asset('assets/images/suitify.png',
                          height: SizeConfig.heightMultiplier * 15,
                          fit: BoxFit.contain))),
              Expanded(flex: 1, child: Container())
            ],
          )),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Failed to pay successfully. Try Again"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
