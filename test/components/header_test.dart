import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';

main() {
  group('header', () {
    DateTime selectedDate;
    Localizations headerWidget;
    bool called = false;
    Function onDateSelected = (DateTime d) {
      called = !called;
    };
    String formattedDate;

    setUp(() {
      selectedDate = new DateTime.now();
      formattedDate = DateFormat('dd/MM').format(selectedDate);
      headerWidget = Localizations(
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
          child: Header(
            onDateSelected: onDateSelected,
            selectedDate: selectedDate,
          ),
        ),
      );
    });

    testWidgets('should show a header', (WidgetTester tester) async {
      await tester.pumpWidget(headerWidget);

      expect(find.byKey(Keys.header), findsOneWidget);
    });

    testWidgets('should show a the working hours', (WidgetTester tester) async {
      await tester.pumpWidget(headerWidget);

      expect(find.text('10 hours'), findsOneWidget);
    });

    testWidgets('should show a the actual day', (WidgetTester tester) async {
      await tester.pumpWidget(headerWidget);

      expect(find.text(formattedDate), findsOneWidget);
    });

    // TODO: Test onTap day
  });
}
