// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:toast/toast.dart';
// import '../size_config.dart';

// class Payment extends StatefulWidget {
//   @override
//   _PaymentState createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   Razorpay razorpay;

//   @override
//   void initState() {
//     super.initState();
//     razorpay = new Razorpay();
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     razorpay.clear();
//   }

//   void openCheckout() {
//     var options = {
//       "key": "rzp_test_c2DnKMGi7febB4",
//       "amount": 145 * 100,
//       "name": "Payment Method",
//       "description": "Payment for your subscription",
//       "prefill": {"contact": "9876543210", "email": "temp@gmail.com"},
//       "external": {
//         "wallets": ["paytm"]
//       },
//       "theme": {"color": "#1443C3"}
//     };

//     try {
//       razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void handlerPaymentSuccess() {
//     print("Pament success");
//     Toast.show("Pament success", context);
//   }

//   void handlerErrorFailure() {
//     print("Pament error");
//     Toast.show("Pament error", context);
//   }

//   void handlerExternalWallet() {
//     print("External Wallet");
//     Toast.show("External Wallet", context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlatButton(
//           onPressed: () {
//             openCheckout();
//           },
//           child: Text(
//             'Pay Now',
//             style: TextStyle(
//                 fontSize: SizeConfig.heightMultiplier * 2.5,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }
// }
