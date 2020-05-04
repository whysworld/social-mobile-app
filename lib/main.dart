import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:redux/redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:tracksite/containers/containers.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/styles/styles.dart';

Future main() async {
  final ios = defaultTargetPlatform == TargetPlatform.iOS;
  await GlobalConfiguration().loadFromAsset("app_config");

  var appSecret = ios
      ? GlobalConfiguration().getString("appCenterSecretIos")
      : GlobalConfiguration().getString("appCenterSecretAndroid");
  

  await AppCenter.start(
      appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
      

  runApp(Tracksite());
}

class Tracksite extends StatefulWidget {
  Tracksite({
    Key key,
  }) : super(key: key);

  @override
  TracksiteState createState() => TracksiteState();
}

class TracksiteState extends State<Tracksite> {
  Store<AppState> store;
  Locale locale;

  updateLocale(String locale) {
    setState(() {
      this.locale = Locale(locale);
    });
  }

  @override
  void initState() {
    super.initState();

    this.locale = Locale('en');
    this.store = Store<AppState>(
      appReducer,
      initialState: AppState.init(),
      middleware: createMiddleware(updateLocale),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FallbackCupertinoLocalisationsDelegate(),
          DefaultCupertinoLocalizations.delegate,
        ],
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
        locale: locale,
        supportedLocales: [
          const Locale('en'),
          const Locale('de'),
          const Locale('fr'),
        ],
        title: 'Time Tracker',
        theme: Styles().theme,
        routes: {
          Routes.splash: (context) => Splash(),
          Routes.login: (context) => Login(),
          Routes.home: (context) => Home(),
          Routes.report: (context) => Report(),
          Routes.reportTimeRecords: (context) => TimeRecords(),
          Routes.timeRecordDetails: (context) => TimeRecordDetails(),
          Routes.reportMaterialRecords: (context) => MaterialRecords(),
          Routes.materialRecordDetails: (context) => MaterialRecordDetails(),
        },
      ),
    );
  }
}
