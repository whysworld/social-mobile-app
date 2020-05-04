import 'package:flutter/widgets.dart';

class Keys {
  static final homePage = const Key('__homePage__');
  static final timeEntryDetailsPage = const Key('__timeEntryDetailsPage__');
  static final loginPage = const Key('__loginPage__');
  static final reportPage = const Key('__reportPage__');
  static final timeRecordsPage = const Key('__TimeRecordsPage__');
  static final timeRecordDetailsPage = const Key('__timeRecordDetailsPage__');
  static final materialRecordsPage = const Key('__materialRecordsPage__');
  static final materialRecordDetailsPage =
      const Key('__materialRecordDetailsPage__');

  static final header = const Key('__header__');
  static final appHeader = const Key('__appHeader__');
  static final loading = const Key('__loading__');
  static final headerInfo = (String id) => Key('__headerInfo__${id}__');
  static final customerInputField = const Key('__customerInputField__');
  static final customerTimeSelectorField =
      const Key('__customerTimeSelectorField__');
  static final customerTypeAheadField = const Key('__customerTypeAheadField__');
  static final bottomButtonsDetailsPage =
      const Key('__bottomButtonsDetailsPage__');
  static final sureDialog = const Key('__sureDialog__');
  static final saveDialog = const Key('__saveDialog__');
  static final calendarDialog = const Key('__calendarDialog__');
  static final languageDialog = const Key('__languageDialog__');

  static final projectTypeAheadCard =
      (String id) => Key('__Project__Type__Ahead__Card__${id}__');
  static final nameTypeAheadCard =
      (String id) => Key('__Name__Type__Ahead__Card__${id}__');
  static final radioButton = (String id) => Key('__Radio__Button__${id}__');
}
