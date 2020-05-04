import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

class ProjectTypeAheadCard extends StatelessWidget {
  final ListProjectDTO project;

  ProjectTypeAheadCard(this.project)
      : super(key: Keys.projectTypeAheadCard(project.id));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Text(
            project.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(" · ${project.customerName}"),
        ],
      ),
    );
  }
}
