import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/styles/styles.dart';

class CustomInputField extends StatefulWidget {
  final String id;
  final IconData prefixIcon;
  final String initialValue;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final Function(dynamic) onChanged;
  final Map errors;

  CustomInputField({
    Key key,
    @required this.id,
    @required this.prefixIcon,
    @required this.initialValue,
    @required this.hintText,
    @required this.errorText,
    @required this.keyboardType,
    @required this.onChanged,
    this.errors,
  }) : super(key: key ?? Keys.customerInputField);

  @override
  _CustomInputFieldState createState() => new _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  TextEditingController _inputTextEditingController;
  FocusNode _inputFocus;
  bool _error;

  @override
  void initState() {
    super.initState();

    _error = false;
    _inputFocus = FocusNode();
    _inputTextEditingController =
        TextEditingController(text: widget.initialValue);
  }

  Widget input(BuildContext context) {
    return Container(
      decoration: Styles().getInputBox,
      child: ListTile(
        leading: Icon(
          widget.prefixIcon,
          color: _error ? Colors.red : Theme.of(context).primaryColor,
        ),
        title: TextField(
          controller: _inputTextEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Formatter.upperFirstLetter(widget.hintText),
            contentPadding: EdgeInsets.only(left: -5),
          ),
          focusNode: _inputFocus,
          keyboardType: widget.keyboardType,
          onChanged: (value) {
            _validateErrors();
            widget.onChanged(value);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        this.input(context),
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

  void _validateErrors() {
    _error = this._inputTextEditingController.text.isEmpty;
    widget.errors?.update(widget.id, (e) => _error);
  }
}
