import 'package:flutter/material.dart';
import 'package:uprik/screens/register_MobileNumber_screen.dart';
import 'package:uprik/screens/otp_submit_screen.dart';
// import 'package:uprik/screens/otp2.dart';
import 'package:uprik/screens/service_area_screen.dart';
import 'package:uprik/screens/profile_screen.dart';
import 'package:uprik/screens/create_account_screen.dart';
import 'package:uprik/screens/identity_verfication_screen.dart';
import 'package:uprik/screens/bank_accountdetails_screen.dart';
import 'package:uprik/screens/personal_information_screen.dart';
import 'constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: PersonalInformation(),
        routes: <String, WidgetBuilder>{
          OtpScreen.id: (context) => OtpScreen(),
        });
  }
}
