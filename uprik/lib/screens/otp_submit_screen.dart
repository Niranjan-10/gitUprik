import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';
import 'package:uprik/constant.dart';
import 'package:uprik/handlers/mobile_otp_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uprik/screens/create_account_screen.dart';
import 'package:uprik/handlers/otp_validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  static String id = 'otpScreen';
  final MobileOtpHandler otpHandler;

  OtpScreen({this.otpHandler});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  String pin;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  OtpValidation _object = OtpValidation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.otpHandler.mobNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: _getFormContents(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// method : _getFormContents
  /// description : This method is used to create form contents like Otp formField and Button
  /// on success : return all the form widgets
  /// on Fail: None
  /// written by : Mcs
  Widget _getFormContents() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _darkRoundedPinPut(),
        SizedBox(
          height: 50.0,
        ),
        myButton(),
      ],
    );
  }

  /// method : _darkRoundedPinPut
  /// description : This method is create otp textfield widget
  /// on success : return textField widget
  /// on Fail: None
  /// written by : Mcs
  Widget _darkRoundedPinPut() {
    BoxDecoration pinPutDecoration = BoxDecoration(
      color: foregroundColor,
      borderRadius: BorderRadius.circular(20),
    );
    return PinPut(
      eachFieldWidth: 50,
      eachFieldHeight: 65,
      fieldsCount: 6,
      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
      textStyle: TextStyle(color: Colors.white, fontSize: 20),
      onSaved: (value) {
        // print(value);
      },
    );
  }

  /// method : _showSnackBar
  /// description : This method is used to show the snackbar
  /// on success : show snackbar with message
  /// on Fail: None
  /// written by : Mcs
  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 25.0),
            ),
          )),
      backgroundColor: foregroundColor,
    );
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  /// method : myButton
  /// description : This method is used to get custom button widget
  /// on success : Button Widget
  /// on Fail: None
  /// written by : Mcs
  Widget myButton() {
    return MaterialButton(
      onPressed: () async {
        print(_pinPutController.text);
        try {
          await validateOtp(
              widget.otpHandler.mobNumber, _pinPutController.text);

          // print(_data);
          // data = _data;
          if (_object.success) {
            SharedPreferences prefs = await SharedPreferences
                .getInstance(); //storing the shared preferences

            //setting the value of shared preferences
            prefs.setString('mobileNo', widget.otpHandler.mobNumber);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateAccount(
                    mobileNo: widget.otpHandler.mobNumber,
                  ),
                ));
          } else {
            _showSnackBar(_object.message);
          }
        } on HttpException {
          _showSnackBar('Sorry!! there is something went wrong');
          print('exception');
        }
      },
      color: foregroundColor,
      textColor: Colors.white,
      child: Icon(
        Icons.arrow_forward_ios,
        size: 24,
      ),
      padding: EdgeInsets.all(20),
      shape: CircleBorder(),
    );
  }

  /// method : validateOtp
  /// description : This method is used to validate the otp by calling the Api
  /// on success : OtpValidation object created to store the status and message
  /// on Fail: Exception
  /// written by : Mcs
  Future validateOtp(String mobile, String pin) async {
    print(mobile);
    print(pin);
    final response = await http
        .get('https://test.uprik.com/verifyOtpApi?mobileno=$mobile&otp=$pin');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // mobileOtpHandler.fromJson(json.decode(response.body));
      // data = json.decode(response.body);
      _object.fromJson(json.decode(response.body));

      // return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load number');
    }
  }
}
