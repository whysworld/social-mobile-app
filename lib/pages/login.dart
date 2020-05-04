import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/containers/containers.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:package_info/package_info.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tracksite/styles/styles.dart';

class LoginPage extends StatefulWidget {
  final Function(String username, String password) onLoginTap;
  final String signInError;

  LoginPage({
    @required this.onLoginTap,
    @required this.signInError,
  }) : super(key: Keys.loginPage);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  bool _hiddeButtonBio;
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  String _username;
  String _password;
  String _version;


  Divider separator = Divider(
    height: 15,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _username = '';
    _password = '';
    _canCheckBiometrics = false;
    _hiddeButtonBio = false;
    _usernameFocusNode = new FocusNode();
    _passwordFocusNode = new FocusNode();
    buildVersion();
    checkBiometrics();
    _usernameFocusNode.addListener(() {
      _hiddeButtonBio = _usernameFocusNode.hasFocus;
    });
    _passwordFocusNode.addListener(() {
      _hiddeButtonBio = _passwordFocusNode.hasFocus;
    });
  }

  void buildVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = getVersionNumber(packageInfo, GlobalConfiguration().getString("environment"));
    });
  }

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;

    var savedUsername = await CustomerSharedPrefernces.getValue("username");
    var savedPassword = await CustomerSharedPrefernces.getValue("password");
    setState(() {
      _canCheckBiometrics =
          canCheckBiometrics && savedUsername != null && savedPassword != null;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;
    if (authenticated) {
      _username = await CustomerSharedPrefernces.getValue("username");
      _password = await CustomerSharedPrefernces.getValue("password");
      this.widget.onLoginTap(_username, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading ? LoadingIndicator() : buildView(context);
    });
  }

  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logo(context),
                  usernameInput(),
                  separator,
                  passwordInput(),
                  errorDisplay(),
                  separator,
                  loginButton(context),
                ].where(notNull).toList(),
              ),
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _canCheckBiometrics && !_hiddeButtonBio
                  ? Row(children: <Widget>[
                      Text(
                        'Biometric Login',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      Divider(
                        indent: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.fingerprint,
                            size: 60,
                          ),
                        ),
                      )
                    ])
                  : null,
            ].where(notNull).toList(),
          ),
          onTap: _authenticate,
        ),
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
            Text(
              "$_version",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget usernameInput() {
    return Container(
      decoration: Styles().getInputBox,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          focusNode: _usernameFocusNode,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).username,
            border: InputBorder.none,
          ),
          validator: (value) =>
              value.isEmpty ? AppLocalizations.of(context).emptyUsername : null,
          onSaved: (value) => _username = value,
        ),
      ),
    );
  }

  Widget passwordInput() {
    return Container(
      decoration: Styles().getInputBox,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: TextFormField(
          maxLines: 1,
          obscureText: true,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).password,
            border: InputBorder.none,
          ),
          validator: (value) =>
              value.isEmpty ? AppLocalizations.of(context).emptyPassword : null,
          onSaved: (value) => _password = value,
        ),
      ),
    );
  }

  Widget errorDisplay() {
    if (widget.signInError != null) {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          widget.signInError,
          style: TextStyle(
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return null;
  }

  Widget loginButton(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width - 250,
      shape: Styles().getButtonThemeShape,
      child: RaisedButton(
        child: Text(
          AppLocalizations.of(context).logIn,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            this.widget.onLoginTap(_username, _password);
          }
        },
      ),
    );
  }
}
