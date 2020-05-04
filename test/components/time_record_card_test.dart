import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

main() {
  group('time record card', () {
    Localizations widget;
    TimeRecord timeRecord;
    bool executedOnTap;
    DateTime now = new DateTime.now();
    Function onTap = () {
      executedOnTap = true;
    };

    setUp(() {
      timeRecord = new TimeRecord(
        description: 'description',
        startTime: now,
        endTime: now,
      );
      executedOnTap = false;
      widget = Localizations(
        delegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate(),
          DefaultCupertinoLocalizations.delegate,
        ],
        locale: Locale('en'),
        child: MediaQuery(
          data: MediaQueryData(),
          child: Card(
            child: Text("test")
          ),
        ),
      );
    });

    testWidgets('should show an client, task, start and end, duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      expect(
        find.text("${new DateFormat('kk:mm').format(now)}"),
        findsNWidgets(2),
      );

      expect(
        find.text(timeRecord.description),
        findsOneWidget,
      );

      expect(
        find.text('0:00 H'),
        findsOneWidget,
      );
    });

    testWidgets('should show a time record card', (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      /*expect(
        find.byKey(Keys.timeRecordCard(timeRecord.id)),
        findsOneWidget,
      );*/
    });

    testWidgets('should execute action ontap', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      //await tester.tap(find.byKey(Keys.timeRecordCard(timeRecord.id)));

      expect(
        executedOnTap,
        true,
      );
    });
  });
}
