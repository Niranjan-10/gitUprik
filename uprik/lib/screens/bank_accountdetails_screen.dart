import 'package:flutter/material.dart';
import 'package:uprik/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class BankAccountDetails extends StatefulWidget {
  @override
  _BankAccountDetailsState createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  GlobalKey<FormState> _formkey = GlobalKey();
  RegExp exp =
      new RegExp(r"(-?([A-Z].\s)?([A-Z][a-z]+)\s?)+([A-Z]'([A-Z][a-z]+))?");
  RegExp accountNumRegEx = new RegExp(r'@"^-?[0-9][0-9,\.]+$"');
  RegExp ifscRegEx = new RegExp(r"^[A-Z]{4}0[A-Z0-9]{6}$");

  FocusNode accountHolderFocusNode = FocusNode();
  FocusNode bankNameFocusNode = FocusNode();
  FocusNode ifscCodeFocusNode = FocusNode();
  FocusNode bankAccountNumberFocusNode = FocusNode();
  bool _autoValidate = false;

  String _acountHolderName;
  String _bankName;
  String _bankAccountNumber;
  String _ifcsCode;

  File _image = File('images/profile.png');
  // final _picker = ImagePicker();
  final picker = ImagePicker();

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
        title: Text('Bank Details'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: _getFormContents(context),
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
  Widget _getFormContents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
      child: Container(
        child: Column(
          children: [
            Container(
              child: TextFormField(
                autovalidate: _autoValidate,
                focusNode: accountHolderFocusNode,
                style: inputTextStyle,
                onFieldSubmitted: (v) {
                  _fieldFocusChange(
                      context, accountHolderFocusNode, bankNameFocusNode);
                },
                onSaved: (accountHoderName) {
                  _acountHolderName = accountHoderName;
                },
                validator: _validateName,
                decoration: InputDecoration(
                  // hintText: 'e.g John',
                  hintStyle: hintTextStyle,
                  labelText: 'Enter Account Holder Name',
                  labelStyle: labelTextStyle,
                  focusedBorder: focusBorder,
                  enabledBorder: enableBorder,
                  disabledBorder: disableBorder,
                  border: border,
                  errorBorder: errorBorder,
                  isDense: true,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
                child: TextFormField(
              autovalidate: _autoValidate,
              textInputAction: TextInputAction.next,
              focusNode: bankNameFocusNode,
              style: inputTextStyle,
              onFieldSubmitted: (v) {
                _fieldFocusChange(
                    context, bankNameFocusNode, bankAccountNumberFocusNode);
              },
              onSaved: (value) {
                _bankName = value;
              },
              validator: _validateName,
              decoration: InputDecoration(
                // hintText: 'e.g City Bank ',
                hintStyle: hintTextStyle,
                labelText: 'Enter Bank Name',
                labelStyle: labelTextStyle,
                focusedBorder: focusBorder,
                enabledBorder: enableBorder,
                disabledBorder: disableBorder,
                border: border,
                errorBorder: errorBorder,
                isDense: true,
              ),
            )),
            SizedBox(
              height: 12,
            ),
            Container(
              child: TextFormField(
                autovalidate: _autoValidate,
                focusNode: bankAccountNumberFocusNode,
                textInputAction: TextInputAction.next,
                style: inputTextStyle,
                onFieldSubmitted: (v) {
                  _fieldFocusChange(
                      context, bankAccountNumberFocusNode, ifscCodeFocusNode);
                },
                onSaved: (value) {
                  _bankAccountNumber = value;
                },
                validator: _validateAccountNumber,
                decoration: InputDecoration(
                  // hintText: 'e.g 54321... ',
                  hintStyle: hintTextStyle,
                  labelText: 'Enter Account Number',
                  labelStyle: labelTextStyle,
                  focusedBorder: focusBorder,
                  enabledBorder: enableBorder,
                  disabledBorder: disableBorder,
                  border: border,
                  errorBorder: errorBorder,
                  isDense: true,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: TextFormField(
                autovalidate: _autoValidate,
                focusNode: ifscCodeFocusNode,
                validator: _validateIFSCCode,
                style: inputTextStyle,
                onSaved: (value) {
                  _ifcsCode = value;
                },
                onFieldSubmitted: (v) {
                  ifscCodeFocusNode.unfocus();
                },
                decoration: InputDecoration(
                  // hintText: 'CGH542...',
                  hintStyle: hintTextStyle,
                  labelText: 'Enter IFSC Code',
                  labelStyle: labelTextStyle,
                  focusedBorder: focusBorder,
                  enabledBorder: enableBorder,
                  disabledBorder: disableBorder,
                  border: border,
                  errorBorder: errorBorder,
                  isDense: true,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: GestureDetector(
                child: getBankPassbookImageWidget(context),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailScreen(
                      path: _image.path,
                    );
                  }));
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'Front Side Of Bank Passbook',
                style: inputTextStyle,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedGradientButton(
              child: Text('Submit'),
              gradient: buttonColor,
            )
          ],
        ),
      ),
    );
  }

  /// method : _validateAccountName
  /// description : This method is used to Validate form,
  /// on success : save the form state
  /// on Fail: Validate again
  /// written by : Mcs
  String _validateName(String accountHoderName) {
    if (accountHoderName.length != 0 && exp.hasMatch(accountHoderName)) {
      return null;
    } else if (accountHoderName.length != 0) {
      return 'Required Field can not be blank';
    } else {
      return 'Should start with uppercase letter';
    }
  }

  /// method : _validateAccountName
  /// description : This method is used to Validate form,
  /// on success : save the form state
  /// on Fail: Validate again
  /// written by : Mcs
  String _validateIFSCCode(String ifsc) {
    if (ifsc.length != 0 && ifscRegEx.hasMatch(ifsc)) {
      return null;
    } else if (ifsc.length != 0) {
      return 'Required Field can not be blank';
    } else {
      return 'This is not correct Format';
    }
  }

  /// method : _validateAccountName
  /// description : This method is used to Validate form,
  /// on success : save the form state
  /// on Fail: Validate again
  /// written by : Mcs
  String _validateAccountNumber(String accountNumber) {
    if (accountNumber.length != 0 && accountNumRegEx.hasMatch(accountNumber)) {
      return null;
    } else if (accountNumber.length != 0) {
      return 'Required Field can not be blank';
    } else {
      return 'Should start with uppercase letter';
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

  /// method : getImage
  /// description : This method handles the uploading the image from camera and gallery.
  /// on success : set uploadedd image
  /// on Fail: None
  /// written by : Mcs
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    // 3. Check if an image has been picked or take with the camera.
    if (pickedFile == null) {
      return;
    }
    // 4. Create a File from PickedFile so you can save the file locally
    // This is a new/additional step.
    File tmpFile = File(pickedFile.path);
    print(tmpFile.path);

    // 5. Get the path to the apps directory so we can save the file to it.
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final String path = appDocDir.path;
    final String fileName =
        basename(pickedFile.path); // Filename without extension
    final String fileExtension = extension(pickedFile.path);

    // 6. Save the file by copying it to the new location on the device.
    tmpFile = await tmpFile.copy('$path/$fileName$fileExtension');
    print(tmpFile);
    setState(() {
      _image = tmpFile;
    });
  }

  /// method : getBankPassbookImageWidget
  /// description : This method is used to create  Stack widget,
  ///               which Contains all the Image and upload buttons.
  /// on success : Stack Widget
  /// on Fail: None
  /// written by : Mcs
  Widget getBankPassbookImageWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: FadeInImage(
              placeholder: AssetImage('images/profile.png'),
              image: AssetImage(_image.path),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: foregroundColor,
              size: 40,
            ),
            tooltip: 'Bank passbook front',
            onPressed: () => _showMyDialog(context),
          ),
        )
      ],
    );
  }

  /// method : _showMyDialog
  /// description : This method is used to pop up alertbox widget,
  ///               which Contains two buttons camera and gallery, to upload image  .
  /// on success : showDialog
  /// on Fail: None
  /// written by : Mcs

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: foregroundColor,
          title: Text(
            'Bank Passbook Front',
            style: TextStyle(
                color: backgroundColor, fontFamily: 'Raleway', fontSize: 18),
          ),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              // button 1
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: backgroundColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(
                        color: backgroundColor, fontFamily: 'Raleway'),
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.photo,
                      color: backgroundColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(
                        color: backgroundColor, fontFamily: 'Raleway'),
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ), // button 2
            ])
          ],
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  File _image = File('images/profile.png');
  final String path;
  DetailScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image(
              image: AssetImage(path),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
