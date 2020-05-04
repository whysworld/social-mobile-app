import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:tracksite/helpers/helpers.dart';

class CustomKeyboard extends StatefulWidget {
  final String description;
  final Function(String value) onChange;

  CustomKeyboard({
    this.description,
    this.onChange,
  }) : super();

  @override
  CustomKeyboardState createState() => CustomKeyboardState();
}

class CustomKeyboardState extends State<CustomKeyboard> {
  final FocusNode _nodeText1 = FocusNode();
  TextEditingController _descriptionTextEditingController;

  @override
  void initState() {
    super.initState();
    FormKeyboardActions.setKeyboardActions(
        context, _buildKeyboardConfig(context));

    _descriptionTextEditingController =
        TextEditingController(text: widget.description);
  }

  KeyboardActionsConfig _buildKeyboardConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          displayCloseWidget: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _nodeText1,
      onChanged: this.widget.onChange,
      controller: _descriptionTextEditingController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText:
            "${Formatter.upperFirstLetter(AppLocalizations.of(context).additionalNotes)}...",
      ),
    );
  }
}
