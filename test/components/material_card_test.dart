import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

main() {
  group('material card', () {
    Localizations widget;
    MaterialRecord materialRecord;
    MaterialRecord modifiedObject;
    Function onEdit = (toModify) {
      modifiedObject = toModify;
    };
    String key;
    Function onDeleteTap = (toDelte) {
      key = toDelte;
    };

    setUp(() {
      materialRecord = new MaterialRecord(
          materialName: 'test', quantity: 5, timeRecordId: 1);
      widget = Localizations(
        delegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate(),
          DefaultCupertinoLocalizations.delegate,
        ],
        locale: Locale('en'),
        child: Card(
            /* child: MaterialCard(
            materialRecord: materialRecord,
            onEdit: onEdit,
            onDeleteTap: onDeleteTap,
          ), */
            ),
      );
    });
  });
}
