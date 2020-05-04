import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';

class LanguageDialog extends StatelessWidget {
  final String languageCode;
  final Function(String value) onChanged;

  LanguageDialog({Key key, this.languageCode, this.onChanged})
      : super(key: key ?? Keys.languageDialog);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Formatter.upperFirstLetter(
          AppLocalizations.of(context).changeLanguage)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile(
            value: 'en',
            groupValue: languageCode,
            onChanged: onChanged,
            title: Text(Formatter.upperFirstLetter(
                AppLocalizations.of(context).english)),
          ),
          RadioListTile(
            value: 'de',
            groupValue: languageCode,
            onChanged: onChanged,
            title: Text(Formatter.upperFirstLetter(
                AppLocalizations.of(context).german)),
          ),
          RadioListTile(
            value: 'fr',
            groupValue: languageCode,
            onChanged: onChanged,
            title: Text(Formatter.upperFirstLetter(
                AppLocalizations.of(context).french)),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
              Formatter.upperFirstLetter(AppLocalizations.of(context).close)),
        ),
      ],
    );
  }
}
