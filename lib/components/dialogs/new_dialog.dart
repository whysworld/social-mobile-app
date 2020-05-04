import 'package:flutter/material.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

class NewDialog extends StatefulWidget {
  final String title;
  final String upText;
  final String downText;
  final Function(BaseName suggestion, String name) onSave;
  final Function service;
  final bool isLoading;

  NewDialog({
    Key key,
    @required this.title,
    @required this.upText,
    @required this.downText,
    @required this.onSave,
    @required this.service,
    @required this.isLoading,
  }) : super(key: key ?? Keys.saveDialog);

  @override
  _NewDialogState createState() => new _NewDialogState();
}

class _NewDialogState extends State<NewDialog> {
  String _name;
  BaseName _suggestion;
  Map _errors;

  @override
  void initState() {
    super.initState();

    _name = '';
    _errors = new Map();
    _errors['suggestion'] = true;
    _errors['name'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Formatter.upperFirstLetter(widget.title)),
      content: widget.isLoading
          ? Column(
              mainAxisSize: MainAxisSize.min, children: [LoadingIndicator()])
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTypeAheadField(
                  externalPadding: 0,
                  id: 'suggestion',
                  text: '',
                  service: widget.service,
                  hintText: widget.upText,
                  errorText:
                      AppLocalizations.of(context).pleaseSelectCorrectCustomer,
                  prefixIcon: Icons.business_center,
                  suggestionWidget: (model) => NameTypeAheadCard(model),
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _suggestion = suggestion;
                    });
                  },
                  errors: _errors,
                ),
                Divider(
                  height: 15,
                  color: Colors.white,
                ),
                CustomInputField(
                  id: 'name',
                  hintText: widget.downText,
                  errorText: AppLocalizations.of(context)
                      .pleaseInputCorrectProjectName,
                  initialValue: '',
                  prefixIcon: Icons.layers,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _name = value;  
                    });
                  },
                  errors: _errors,
                ),
              ],
            ),
      actions: <Widget>[
        FlatButton(
          onPressed:
              widget.isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(
            Formatter.upperFirstLetter(AppLocalizations.of(context).cancel),
          ),
        ),
        FlatButton(
          onPressed: widget.isLoading || _errors.containsValue(true)
              ? null
              : () => widget.onSave(_suggestion, _name),
          child: Text(
            Formatter.upperFirstLetter(AppLocalizations.of(context).save),
          ),
        ),
      ],
    );
  }
}
