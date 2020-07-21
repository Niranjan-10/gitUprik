import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

const Color foregroundColor = Color(0xffE74292);
const Color backgroundColor = Color(0xff2B2B52);

///Linear Gradient
LinearGradient buttonColor = LinearGradient(
    colors: <Color>[Color(0xffFE7F9C), foregroundColor, Color(0xff8E2366)]);

/// Focused border
OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(4)),
  borderSide: BorderSide(width: 2, color: foregroundColor),
);

///  disable border
OutlineInputBorder disableBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(4)),
  borderSide: BorderSide(width: 2, color: foregroundColor),
);

/// enable border
OutlineInputBorder enableBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(4)),
  borderSide: BorderSide(width: 2, color: foregroundColor),
);

/// border
OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(
      width: 3,
    ));

/// error border
OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 2, color: foregroundColor));

OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 2, color: foregroundColor));

///Label Text  Style
TextStyle labelTextStyle = TextStyle(color: foregroundColor);

///Hint Text  Style
TextStyle hintTextStyle = TextStyle(color: foregroundColor);

///Input Text  Style
TextStyle inputTextStyle =
    TextStyle(color: foregroundColor, fontFamily: "Raleway");

/// Theme color scheme
ThemeData theme = ThemeData(
    primaryColor: foregroundColor,
    buttonColor: foregroundColor,
    cursorColor: foregroundColor,
    // dividerColor: foregroundColor,
    focusColor: foregroundColor,
    fontFamily: "Raleway",
    unselectedWidgetColor: foregroundColor,
    colorScheme: ColorScheme.light(primary: foregroundColor),
    // accentColor: foregroundColor,
    splashColor: foregroundColor);

class MyFunction extends StatefulWidget {
  final Function function;
  MyFunction({@required this.function});
  @override
  _MyFunctionState createState() => _MyFunctionState();
}

class _MyFunctionState extends State<MyFunction> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        widget.function();
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
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-2, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
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
