import 'package:flutter/material.dart';
import 'package:uprik/constant.dart';
import 'dart:async';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  GlobalKey<FormState> _formkey = GlobalKey();
  int _radioValue = 0;
  int _groupValue = -1;
  DateTime selectedDate = DateTime.now();

  String _dob = 'Date of Birth';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Personal Information'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: _getFormContents(),
          ),
        ),
      ),
    );
  }

  /// method : _getFormContents
  /// description : This method is used to create  Column widget,
  ///               which Contains all the Form fields like TextFormField, Raised Button etc.
  /// on success : Container cointaing Column Widget
  /// on Fail: None
  /// written by : Mcs

  Widget _getFormContents() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.,
              children: <Widget>[
                _myRadioButton(value: 0, onChanged: _setGenderValue),
                Text(
                  'Male',
                  style: inputTextStyle,
                ),
                SizedBox(
                  width: 5.0,
                ),
                _myRadioButton(value: 1, onChanged: _setGenderValue),
                Text(
                  'Female',
                  style: inputTextStyle,
                ),
                SizedBox(
                  width: 10.0,
                ),
                _myRadioButton(value: 2, onChanged: _setGenderValue),
                Text(
                  'Other',
                  style: inputTextStyle,
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _dob,
                  style: inputTextStyle,
                ),
                SizedBox(
                  width: 20.0,
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('pick date'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                // hintText: 'Fathe Name ',
                labelText: 'Father\'s Name ',
                border: border,
                focusedBorder: focusBorder,
                disabledBorder: disableBorder,
                errorBorder: errorBorder,
                enabledBorder: enableBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// method : _myRadioButton
  /// description : This method is used to create  Column widget,
  ///               which Contains all the Form fields like TextFormField, Raised Button etc.
  /// on success : Container cointaing Column Widget
  /// on Fail: None
  /// written by : Mcs
  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return Radio(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      activeColor: foregroundColor,
      focusColor: foregroundColor,
      hoverColor: foregroundColor,
      // title: Text(
      //   title,
      //   style: TextStyle(
      //     fontSize: 10,
      //   ),
    );
  }

  /// method : _setGenderValue
  /// description : This method is used to create  Column widget,
  ///               which Contains all the Form fields like TextFormField, Raised Button etc.
  /// on success : Container cointaing Column Widget
  /// on Fail: None
  /// written by : Mcs
  void _setGenderValue(int value) {
    setState(() {
      switch (value) {
        case 0:
          {
            _groupValue = value;
            print(_groupValue);
          }
          break;
        case 1:
          {
            _groupValue = value;
            print(_groupValue);
          }
          break;

        case 2:
          {
            _groupValue = value;
            print(_groupValue);
          }
          break;
      }
    });
  }

  /// method : _selectDate
  /// description : This method is used to create  Column widget,
  ///               which Contains all the Form fields like TextFormField, Raised Button etc.
  /// on success : Container cointaing Column Widget
  /// on Fail: None
  /// written by : Mcs
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          child: child,
          data: ThemeData(
            // primaryColor: const Color(0xFF8CE7F1),
            // accentColor: const Color(0xFF8CE7F1),
            colorScheme: ColorScheme.light(primary: foregroundColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
        );
      },
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      // "${selectedDate}".split(' ')[0]
      setState(
        () {
          selectedDate = picked;
          _dob = "${selectedDate}".split(' ')[0];
          print(selectedDate);
        },
      );
    }
  }
}
