import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

class NameTypeAheadCard extends StatelessWidget {
  final BaseName model;

  NameTypeAheadCard(this.model) : super(key: Keys.nameTypeAheadCard(model.id));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        model.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
