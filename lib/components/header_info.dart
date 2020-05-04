import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/styles/styles.dart';

class HeaderInfo extends StatelessWidget {
  final String title;
  final int minutes;

  HeaderInfo({Key key, this.title, this.minutes})
      : super(key: key ?? Keys.headerInfo(title));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: Styles().getHeaderInfo,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Formatter.upperFirstLetter(title),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                Formatter.minutesToHMMFormatWithoutSpace(minutes),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
