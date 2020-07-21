import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:uprik/constant.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image = File('images/profile.png');
  // final _picker = ImagePicker();
  final picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  getProfileImageWidget(context),
                  SizedBox(height: 30),
                  RaisedGradientButton(
                    child: Text('Identity Verification'),
                    gradient: buttonColor,
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  RaisedGradientButton(
                    child: Text('Profile Information'),
                    gradient: buttonColor,
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  RaisedGradientButton(
                    child: Text('Add Bank Details'),
                    gradient: buttonColor,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// method : getProfileImageWidget
  /// description : This method is used to create  Stack widget,
  ///               which Contains all the Image and upload buttons.
  /// on success : Stack Widget
  /// on Fail: None
  /// written by : Mcs
  Widget getProfileImageWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: FadeInImage(
              placeholder: AssetImage('images/profile.png'),
              image: AssetImage(_image.path),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 101.0),
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: foregroundColor,
              size: 40,
            ),
            tooltip: 'Increase volume by 10',
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
            'Profile Photo',
            style: TextStyle(color: backgroundColor, fontFamily: 'Raleway'),
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

/// class : RaisedGradientButton
///  type : stateless class
/// description : create the gradient button of login
/// output : return gradient button
///  on fail : None

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
