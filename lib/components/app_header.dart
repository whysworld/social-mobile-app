import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final Future<bool> Function() onClose;
  final Widget action;

  AppHeader({
    Key key,
    @required this.title,
    this.onClose,
    this.icon,
    this.action,
  }) : super(key: key ?? Keys.appHeader);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        Formatter.upperFirstLetter(title),
        style: TextStyle(color: Colors.black, fontFamily: 'Arciform'),
      ),
      backgroundColor: Colors.white,
      leading: Center(
        child: IconButton(
          icon: Icon(
            icon == null ? Icons.arrow_back : icon,
            color: Colors.black,
          ),
          onPressed: () async {
            var pop = true;
            if (onClose != null) pop = await onClose();

            if (pop) Navigator.of(context).pop();
          },
        ),
      ),
      actions: <Widget>[
        Center(
          child: action,
        ),
      ],
      elevation: 0.25,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
