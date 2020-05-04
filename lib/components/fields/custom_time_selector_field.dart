import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracksite/helpers/date_text_input_formatter.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/styles/styles.dart';

class CustomTimeSelectorField extends StatefulWidget {
  final String id;
  final TimeOfDay initialValue;
  final String hintText;
  final String errorText;
  final Function(dynamic) onChanged;
  final Map errors;

  CustomTimeSelectorField({
    Key key,
    @required this.id,
    @required this.initialValue,
    @required this.hintText,
    @required this.errorText,
    @required this.onChanged,
    @required this.errors,
  }) : super(key: key ?? Keys.customerTimeSelectorField);

  @override
  _CustomTimeSelectorFieldState createState() =>
      new _CustomTimeSelectorFieldState();
}

class _CustomTimeSelectorFieldState extends State<CustomTimeSelectorField> {
  FocusNode _focusNode;
  TextEditingController _timeSelectorTextEditingController;
  DateTextInputFormatter _maskFormatter;
  bool _error;

  @override
  void initState() {
    super.initState();

    _error = false;
    _focusNode = new FocusNode();
    _timeSelectorTextEditingController = TextEditingController(
        text: Formatter.timeOfDayToString(widget.initialValue));
    _maskFormatter = new DateTextInputFormatter();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        onFinishEdit();
      }
    });
  }

  void onFinishEdit() {
    var time = _timeSelectorTextEditingController.text;
    var isValidTime =
        RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(time);

    if (isValidTime) {
      widget.onChanged(
        TimeOfDay(
          hour: int.parse(time.split(":")[0]),
          minute: int.parse(time.split(":")[1]),
        ),
      );
    }

    setState(() {
      _error = !isValidTime;
    });

    widget.errors.update(widget.id, (e) => _error);
  }

  Widget timeSelector(BuildContext context) {
    return Container(
      decoration: Styles().getInputBoxNoBorder,
      child: ListTile(
        leading: Icon(
          Icons.access_time,
          color: Theme.of(context).primaryColor,
        ),
        title: TextField(
          focusNode: _focusNode,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Formatter.upperFirstLetter(
              !_focusNode.hasFocus ? widget.hintText : 'HH:MM',
            ),
          ),
          controller: _timeSelectorTextEditingController,
          inputFormatters: [_maskFormatter],
          keyboardType: TextInputType.number,
          onEditingComplete: onFinishEdit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        this.timeSelector(context),
        _error
            ? Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  decoration: Styles().getInputBoxNoBorder,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Formatter.upperFirstLetter(widget.errorText),
                      style: Styles().getErrorTextStyles,
                    ),
                  ),
                ),
              )
            : null,
      ].where(notNull).toList(),
    );
  }
}
