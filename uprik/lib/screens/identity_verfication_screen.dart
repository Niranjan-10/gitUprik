import 'package:flutter/material.dart';
import 'package:uprik/constant.dart';

class IdentityVerification extends StatefulWidget {
  @override
  _IdentityVerificationState createState() => _IdentityVerificationState();
}

class _IdentityVerificationState extends State<IdentityVerification> {
  String adharno;
  String name;
  String voterIdno;
  String panNo;
  String drivingLicenseNumber;

  List<String> ids = ['Aadhaar', 'PAN Card', 'Driving License', 'Voter ID'];
  String dropdownValue = 'Aadhaar';
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('Identification Verification'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                getIdOptionsDropdown(),
                Form(
                  key: _formkey,
                  child: TextFormField(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// method : _showMyDialog
  /// description : This method is used to pop up alertbox widget,
  ///               which Contains two buttons camera and gallery, to upload image  .
  /// on success : showDialog
  /// on Fail: None
  /// written by : Mcs

  Widget getIdOptionsDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: foregroundColor, width: 2.0),
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
          items: ids.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
