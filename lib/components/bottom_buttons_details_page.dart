import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/styles/styles.dart';

class BottomButtonsDetailsPage extends StatelessWidget {
  final bool disabled;
  final Function() onTapTop;
  final Function() onTapBottom;

  BottomButtonsDetailsPage(
      {Key key, this.disabled, this.onTapTop, this.onTapBottom})
      : super(key: key ?? Keys.bottomButtonsDetailsPage);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width - 40,
      shape: Styles().getButtonThemeShape,
      buttonColor: Styles().getButtonColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          onTapTop != null
              ? OutlineButton(
                  disabledTextColor: Styles().getDisabledButtonColor,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: disabled
                      ? null
                      : () {
                          onTapTop();
                        },
                  child: Text(
                    AppLocalizations.of(context).saveAndAddMore.toUpperCase(),
                  ),
                )
              : null,
          RaisedButton(
            disabledColor: Colors.grey[400],
            disabledTextColor: Colors.grey[600],
            elevation: 0,
            highlightElevation: 0,
            disabledElevation: 0,
            textColor: Colors.white,
            clipBehavior: Clip.hardEdge,
            onPressed: disabled
                ? null
                : () {
                    onTapBottom();
                    Navigator.of(context).pop();
                  },
            child: Text(
              AppLocalizations.of(context).confirm.toUpperCase(),
            ),
          ),
        ].where(notNull).toList(),
      ),
    );
  }
}
