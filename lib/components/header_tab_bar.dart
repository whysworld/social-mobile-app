import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';

class HeaderTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  HeaderTabBar({Key key, this.child}) : super(key: key ?? Keys.appHeader);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
