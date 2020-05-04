import 'package:flutter/material.dart';
import 'package:tracksite/helpers/helpers.dart';

class SplashPage extends StatefulWidget {
  final Function() onInit;

  SplashPage({
    @required this.onInit,
  }) : super(key: Keys.loginPage);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  Divider separator = Divider(
    height: 15,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    this.widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: logo(context),
      ),
    );
  }

  Widget logo(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/logo-login.png'),
              height: 80,
            ),
            separator,
            Text(
              "Tracksite",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
