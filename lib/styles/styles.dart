import 'package:flutter/material.dart';

class Styles {
  Color get getPrimarySwatch => Colors.red;

  ThemeData get theme =>
      ThemeData(primarySwatch: getPrimarySwatch, fontFamily: 'AvenirNext');

  Color get getButtonColor => Color.fromARGB(255, 118, 132, 149);

  Color get getDisabledButtonColor => Color.fromARGB(255, 118, 132, 149);

  Color get getAppBarColor => Color.fromARGB(255, 68, 68, 77);

  BoxDecoration get getHeaderInfo => BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: getButtonColor,
      );

  BoxDecoration get getInputBox => BoxDecoration(
        color: Colors.grey[200],
        border: new Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.circular(30),
      );

  BoxDecoration get getInputBoxNoBorder => BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      );

  Color get getReportPageBackgroundColor => Colors.grey[100];

  BoxDecoration get getReportContainer => BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            blurRadius: 1.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              0, // horizontal, move right
              0, // vertical, move down 10
            ),
          )
        ],
      );

  RoundedRectangleBorder get getButtonThemeShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      );

  TextStyle get getErrorTextStyles => TextStyle(
        color: Colors.red[200],
        fontWeight: FontWeight.w200,
        fontSize: 12,
      );
}
