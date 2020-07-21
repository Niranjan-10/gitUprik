import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uprik/constant.dart';
import 'package:uprik/handlers/mobile_otp_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uprik/screens/otp_submit_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';

class MobileNumberRegistration extends StatefulWidget {
  @override
  _MobileNumberRegistrationState createState() =>
      _MobileNumberRegistrationState();
}

class _MobileNumberRegistrationState extends State<MobileNumberRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _number;
  bool _isLoading = false;
  FocusNode _focus = FocusNode();

  MobileOtpHandler mobileOtpHandler =
      MobileOtpHandler(); //future object of MobileOtpHandler class
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  fetchMobileOtp(String mobile) async {
    final response =
        await http.get('https://test.uprik.com/generateOtp?mobileNo=$mobile');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      mobileOtpHandler.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: LoadingOverlay(
          isLoading: _isLoading,
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                    child: new Container(
                  margin: new EdgeInsets.all(15.0),
                  child: new Form(
                    autovalidate: _autoValidate,
                    key: _formKey,

                    // autovalidate: _autoValidate,
                    // child: FormUI(),
                    child: _formContents(),
                  ),
                )),
              ),
            ),
          ),
        ),
      ),
    ));
  }

// widget for the form elements
  Widget _formContents() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          margin: EdgeInsets.only(top: 100.0),
          child: SizedBox(
            height: 80.0,
            child: TextFormField(
              focusNode: _focus,
              validator: validateMobile,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.white),
              onSaved: (String val) {
                _number = val;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  helperText: ' ',
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 2.0, color: Colors.greenAccent),
                  ),
                  labelText: 'Mobile',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        RaisedGradientButton(
          child: Text('submit'),
          gradient: buttonColor,
          onPressed: () {
            _validateInputs();
            // try {
            //   //validating the inputs

            // } on HttpException {
            //   print('error');
            // }
            // setState(() {
            //   _isLoading = true;
            // });
          },
        ),
      ],
    );
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  void _validateInputs() async {
    var success;
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      try {
        await fetchMobileOtp(_number);

        setState(() {
          _isLoading = false;
        });

        if (mobileOtpHandler.success) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  otpHandler: mobileOtpHandler,
                ),
              ));
        } else {
          _displaySnackBar(context, mobileOtpHandler.message);
        }
      } on HttpException {
        print('exception');
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  /// method : _displaySnackBar
  /// description : This method is used to show snackbar,
  /// on success : snackbar
  /// on Fail:
  /// written by : Asiczen
  _displaySnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      backgroundColor: Colors.blueAccent,
      content: Text(text),
      elevation: 7.0,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class OpacityWidget extends StatelessWidget {
  const OpacityWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        margin: EdgeInsets.only(bottom: 250.0),
        width: double.infinity,
        height: 300.0,
        decoration: new BoxDecoration(
            // color: Colors.green,
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              bottomLeft: const Radius.circular(50.0),
              bottomRight: const Radius.circular(50.0),
            )),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          // offset: Offset(0.0, 1.5),
          // blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
