import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';

class SureDialog extends StatelessWidget {
  SureDialog({Key key}) : super(key: key ?? Keys.sureDialog);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Formatter.upperFirstLetter(
          AppLocalizations.of(context).changesWithoutSaving)),
      content: Text(
          Formatter.upperFirstLetter(AppLocalizations.of(context).sureToExit)),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child:
              Text(Formatter.upperFirstLetter(AppLocalizations.of(context).no)),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
              Formatter.upperFirstLetter(AppLocalizations.of(context).yes)),
        ),
      ],
    );
  }
}
