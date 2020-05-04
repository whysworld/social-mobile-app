import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key ?? Keys.loading);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
