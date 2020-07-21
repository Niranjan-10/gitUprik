import 'package:flutter/material.dart';
import 'package:uprik/constant.dart';
import 'package:uprik/validators/validators.dart';
import 'package:device_info/device_info.dart'; // package for getting deviceId
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uprik/screens/profile_screen.dart';
import 'package:page_transition/page_transition.dart';

class CreateAccount extends StatefulWidget {
  final String mobileNo;

  CreateAccount({@required this.mobileNo});
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> cities = ['Bhubaneswar', 'Chennai', 'Cuttack', 'Keonjhar'];

  String dropdownValue = 'Bhubaneswar';

  /// form value
  String email;
  String name;
  String city;
  String mobile;

  /// focus node variables
  final focus = FocusNode();
  bool _autoValidate = false;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  String deviceId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Account'),
      ),
      backgroundColor: backgroundColor,
      body: Container(
        child: Form(
          key: _formkey,
          child: getFormContents(),
        ),
      ),
    );
  }

  /// method : getFormContents
  /// description : This method is used to create  Column widget,
  ///               which Contains all the Form fields like TextFormField, Raised Button etc.
  /// on success : Column Widget
  /// on Fail: None
  /// written by : Mcs

  Widget getFormContents() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
                // autofocus: true,
                focusNode: _emailFocus,
                autovalidate: _autoValidate,
                decoration: new InputDecoration(
                  isDense: true,
                  labelText: "Email",
                  labelStyle: labelTextStyle,
                  // filled: false,
                  // fillColor: Color(0xFFF2F2F2),
                  focusedBorder: focusedBorder,
                  disabledBorder: disableBorder,
                  enabledBorder: enableBorder,
                  border: border,
                  errorBorder: errorBorder,
                  focusedErrorBorder: focusBorder,
                  hintText: 'e.g John@email.com',
                  hintStyle: hintTextStyle,
                  // fillColor: Colors.green
                ),
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: inputTextStyle,
                onFieldSubmitted: (v) {
                  _fieldFocusChange(context, _emailFocus, _nameFocus);
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: TextFormField(
                focusNode: _nameFocus,
                // autofocus: true,
                autovalidate: _autoValidate,
                decoration: new InputDecoration(
                    isDense: true,
                    labelText: "Name",
                    labelStyle: labelTextStyle,
                    // filled: true,
                    // fillColor: Color(0xFFF2F2F2),
                    focusedBorder: focusedBorder,
                    disabledBorder: disableBorder,
                    enabledBorder: enableBorder,
                    border: border,
                    errorBorder: errorBorder,
                    focusedErrorBorder: focusBorder,
                    hintText: 'e.g John doe',
                    hintStyle: hintTextStyle
                    // fillColor: Colors.green
                    ),
                validator: (val) {},
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: inputTextStyle,
                onFieldSubmitted: (v) {
                  _fieldFocusChange(context, _nameFocus, _mobileFocus);
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(child: getCityNameDropdown()),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: TextFormField(
                focusNode: _mobileFocus,
                // autofocus: true,
                enabled: false,
                autovalidate: _autoValidate,
                initialValue: widget.mobileNo,
                decoration: new InputDecoration(
                    isDense: true,
                    labelText: "Phone Number",
                    labelStyle: labelTextStyle,
                    // filled: true,
                    // fillColor: Color(0xFFF2F2F2),
                    focusedBorder: focusedBorder,
                    disabledBorder: disableBorder,
                    enabledBorder: enableBorder,
                    border: border,
                    errorBorder: errorBorder,
                    focusedErrorBorder: focusBorder,
                    hintText: 'e.g John'
                    // fillColor: Colors.green
                    ),
                validator: (val) {},
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: inputTextStyle,
                onFieldSubmitted: (v) {
                  _fieldFocusChange(context, _mobileFocus, _countryFocus);
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: TextFormField(
                enableInteractiveSelection: false,
                enabled: false,
                initialValue: "INDIA",
                focusNode: _countryFocus,
                // autofocus: true,
                autovalidate: _autoValidate,
                decoration: new InputDecoration(
                    isDense: true,
                    labelText: "Enter Country",
                    labelStyle: labelTextStyle,
                    // filled: true,
                    // fillColor: Color(0xFFF2F2F2),
                    focusedBorder: focusedBorder,
                    disabledBorder: disableBorder,
                    enabledBorder: enableBorder,
                    border: border,
                    errorBorder: errorBorder,
                    focusedErrorBorder: focusBorder,
                    hintText: 'e.g John',
                    hintStyle: hintTextStyle

                    // fillColor: Colors.green
                    ),
                validator: (val) {},
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                style: inputTextStyle,
                onFieldSubmitted: (v) {
                  _countryFocus.unfocus();
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50.0,
              child: RaisedGradientButton(
                child: Text('Proceed'),
                gradient: buttonColor,
                onPressed: () {
                  print(deviceId);
                  Navigator.push(context, SlideRightRoute(page: Profile()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// method : getCityNameDropdown
  /// description : This method is used to get the dropdown widgrt that contains cities
  /// on success : Dropdown Widget
  /// on Fail: None
  /// written by : Mcs

  Widget getCityNameDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: foregroundColor, width: 2.0),
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(
            Icons.arrow_downward,
            color: foregroundColor,
          ),
          iconSize: 24,
          elevation: 16,
          style: inputTextStyle,
          underline: Container(
            height: 40,
            // color: backgroundColor,
            decoration: BoxDecoration(),
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: cities.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// method : _validateInputs
  /// description : This method is used to Validate form,
  /// on success : save the form state
  /// on Fail: Validate again
  /// written by : Mcs

  void _validateInputs() {
    if (_formkey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  /// method : _fieldFocusChange
  /// description : This method is used to Validate form,
  /// on success : save the form state
  /// on Fail: Validate again
  /// written by : Mcs
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /// method : __getId
  /// description : This method is used to get deviceId using DeviceInfo Plugin ,
  /// on success : return future object of string(deviceid)
  /// on Fail: Exception
  /// written by : Mcs

  Future<void> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceId = androidDeviceInfo.androidId;
        });
      } else {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        setState(() {
          deviceId = iosDeviceInfo.identifierForVendor;
        });
      }
    } catch (PlatformException) {
      print('can not get id');
    }
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
