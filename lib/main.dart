//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recruitment/provider/c_home_jobs.dart';
import 'package:recruitment/provider/c_home_recruiters.dart';
import 'package:recruitment/provider/c_notification.dart';
import 'package:recruitment/provider/p_auth.dart';
import 'package:recruitment/provider/r_candidate_search.dart';
import 'package:recruitment/provider/r_home_open_positions.dart';
import 'package:recruitment/screens/Contact_Us.dart';
import 'package:recruitment/screens/Old%20UI/r_otp_screen.dart';
import 'package:recruitment/screens/candidate_home_page.dart';
import 'package:recruitment/screens/change_password.dart';
import 'package:recruitment/screens/menu.dart';
import 'package:recruitment/screens/otp_screen.dart';
import 'package:recruitment/screens/payment_screen.dart';
import 'package:recruitment/screens/recruiter_candidate_search.dart';
import 'package:recruitment/screens/recruiter_charges.dart';
import 'package:recruitment/screens/recruiter_complete_profile.dart';
import 'package:recruitment/screens/recruiter_home_page.dart';
import 'package:recruitment/screens/recruiter_login.dart';
import 'package:recruitment/screens/recruiter_otp.dart';
import 'package:recruitment/screens/recruiter_register.dart';
import 'package:recruitment/screens/register_display.dart';
import 'package:recruitment/screens/settings.dart';
import 'package:recruitment/screens/splash_screen.dart';
import 'package:recruitment/screens/splash_screen_2.dart';
import 'package:recruitment/size_config.dart';
import 'provider/c_view_recruiters.dart';
import 'screens/Reset_password.dart';
import 'screens/candidate_charges.dart';
import 'screens/candidate_complete_profile.dart';
import 'screens/candidate_recruiter_details.dart';
import 'screens/candidate_register.dart';
import 'package:recruitment/screens/Forgot_password.dart';
import 'package:recruitment/screens/candidate_login.dart';
import 'package:recruitment/screens/candidate_password_successful.dart';
import 'screens/candidate_Notification.dart';
import 'package:recruitment/screens/candidate_profile.dart';
import 'package:recruitment/screens/Contact_Us.dart';
import 'package:recruitment/screens/change_password.dart';
import 'package:recruitment/screens/menu.dart';

import 'screens/recruiter_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CandidateNotificationP(),
          ),
          ChangeNotifierProxyProvider<Auth, CHomeJobsP>(
            create: (_) => CHomeJobsP(),
            update: (_, auth, previousProduct) =>
                CHomeJobsP(token: auth.token, urlfront: auth.urlFront),
          ),
          ChangeNotifierProxyProvider<Auth, CHomeRecruitersP>(
            create: (_) => CHomeRecruitersP(),
            update: (_, auth, previousProduct) =>
                CHomeRecruitersP(token: auth.token, urlfront: auth.urlFront),
          ),
          ChangeNotifierProxyProvider<Auth, CViewRecruitersP>(
            create: (_) => CViewRecruitersP(),
            update: (_, auth, previousProduct) =>
                CViewRecruitersP(token: auth.token, urlfront: auth.urlFront),
          ),
          ChangeNotifierProxyProvider<Auth, RHomeOPP>(
            create: (_) => RHomeOPP(),
            update: (_, auth, previousProduct) =>
                RHomeOPP(token: auth.rtoken, urlfront: auth.urlFront),
          ),
          ChangeNotifierProvider(
            create: (ctx) => RCandidateSearchP(),
          )
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) =>
                LayoutBuilder(builder: (context, constraints) {
                  return OrientationBuilder(builder: (context, orientation) {
                    SizeConfig().init(constraints, orientation);
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        // textTheme:
                        //     GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
                        //primarySwatch: Color(0xff1443C3),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),

                      //initialRoute: '/',
                      home: auth.isAuth != 0
                          ? (auth.isAuth == 1
                              ? CandidateHomePage()
                              : RecruiterHomePage())
                          : FutureBuilder(
                              future: auth.autoLogin(),
                              builder: (ctx, snapshot) =>
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? SplashScreen2()
                                      : SplashScreenState(),
                            ),

                      //print(auth.isAuth2);
                      //home: SplashScreenState(),

                      routes: {
                        //'/': (context) => (SplashScreenState()),
                        //C_Register.routeName: (context) => (C_Register()),
                        //R_Register.routeName: (context) => (R_Register()),
                        'R_Register': (context) => (R_Register()),
                        'CLogin': (context) => (CLogin()),
                        'C_Register': (context) => (C_Register()),
                        'RLogin': (context) => (RLogin()),
                        'ForgotPassword': (context) => (ForgotPassword()),
                        'ResetPassword': (context) => (ResetPassword()),
                        'PasswordSuccess': (context) => (PasswordSuccess()),
                        'CandidateCompleteProfile': (context) =>
                            (CandidateCompleteProfile()),
                        'RecruiterCompleteProfile': (context) =>
                            (RecruiterCompleteProfile()),
                        'CandidateCharges': (context) => (CandidateCharges()),
                        'RecruiterCharges': (context) => (RecruiterCharges()),
                        'RegisterDisplay': (context) => (RegisterDisplay()),
                        OtpScreen.routeName: (context) => (OtpScreen()),
                        ROtpScreen.routeName: (context) => (ROtpScreen()),
                        'CandidateHomePage': (context) => (CandidateHomePage()),
                        'Menu': (context) => (Menu())
                        //'Payment': (context) => (Payment())
                      },
                    );
                  });
                })));
  }
}
