import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/styles/styles.dart';

class CustomTypeAheadField extends StatefulWidget {
  final String id;
  final String text;
  final Function service;
  final dynamic addButton;
  final Function onAddButtonPress;
  final IconData prefixIcon;
  final String hintText;
  final String errorText;
  final Function(dynamic) suggestionWidget;
  final Function(dynamic) onSuggestionSelected;
  final Map errors;
  final double externalPadding;
  final bool showBorder;

  CustomTypeAheadField({
    Key key,
    @required this.id,
    @required this.text,
    @required this.service,
    @required this.prefixIcon,
    @required this.hintText,
    @required this.errorText,
    @required this.suggestionWidget,
    @required this.onSuggestionSelected,
    this.errors,
    this.addButton,
    this.onAddButtonPress,
    this.externalPadding,
    this.showBorder = false,
  }) : super(key: key ?? Keys.customerTypeAheadField);

  @override
  _CustomTypeAheadFieldState createState() => new _CustomTypeAheadFieldState();
}

class _CustomTypeAheadFieldState extends State<CustomTypeAheadField> {
  TextEditingController _typeAheadController;
  FocusNode _typeAheadFocus;
  bool _error;
  String _selected;

  @override
  void initState() {
    super.initState();

    _error = false;
    _selected = '';
    _typeAheadFocus = FocusNode();
    _typeAheadFocus.addListener(() {
      if (!_typeAheadFocus.hasFocus && widget.errors != null) {
        widget.errors.update(widget.id, (e) => _error || _selected.isEmpty);
      }
    });
    _typeAheadController = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text) {
      _typeAheadController = TextEditingController(text: widget.text);
      _error = false;
    }
  }

  Widget typeAhead(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.externalPadding ?? 8.0),
      child: Container(
        decoration: !widget.showBorder
            ? Styles().getInputBoxNoBorder
            : Styles().getInputBox,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(_typeAheadFocus);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6.0),
            child: TypeAheadField(
              getImmediateSuggestions: true,
              textFieldConfiguration: TextFieldConfiguration(
                style: TextStyle(height: 1.4),
                onChanged: (value) {
                  _error = true;
                  _selected = '';
                },
                controller: _typeAheadController,
                focusNode: _typeAheadFocus,
                decoration: InputDecoration(
                  prefix: Padding(
                    padding: EdgeInsets.only(right: 15),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 6.0),
                    child: Icon(
                      widget.prefixIcon,
                      color:
                          _error ? Colors.red : Theme.of(context).primaryColor,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_typeAheadController.text.isEmpty) {
                        FocusScope.of(context).requestFocus(_typeAheadFocus);
                      } else {
                        setState(() {
                          _typeAheadController.text = "";
                          _error = true;
                          _selected = '';
                        });
                      }
                    },
                    child: Icon(_typeAheadController.text.isEmpty
                        ? Icons.arrow_drop_down
                        : Icons.close),
                  ),
                  hintText: Formatter.upperFirstLetter(widget.hintText),
                  border: InputBorder.none,
                ),
              ),
              suggestionsCallback: (pattern) async {
                if (widget.addButton != null)
                  return await widget.service(pattern)
                    ..add(widget.addButton);
                else
                  return await widget.service(pattern);
              },
              itemBuilder: (context, suggestion) {
                if (!isNumeric(suggestion.id)) return addButton(suggestion.id);
                return widget.suggestionWidget(suggestion);
              },
              onSuggestionSelected: (suggestion) {
                _typeAheadController.text = suggestion.name;
                _error = false;
                _selected = suggestion.name;
                widget.onSuggestionSelected(suggestion);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlatButton(
            shape: Styles().getButtonThemeShape,
            color: Styles().getDisabledButtonColor,
            textColor: Colors.white,
            onPressed: widget.onAddButtonPress,
            child: Text(
              text.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        this.typeAhead(context),
        _error
            ? FractionallySizedBox(
                widthFactor: 0.95,
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
