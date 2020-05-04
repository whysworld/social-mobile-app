import 'package:tracksite/models/models.dart';

class SetSelectedTimeRecordAction {
  final TimeRecord timeRecord;

  SetSelectedTimeRecordAction(this.timeRecord);

  @override
  String toString() {
    return 'SetSelectedTimeRecordAction{timeRecord: $timeRecord}';
  }
}

class SaveAndAddMoreTimeRecordAction {
  final LocalNavigator navigator;
  final TimeRecord timeRecord;

  SaveAndAddMoreTimeRecordAction(this.navigator, this.timeRecord);

  @override
  String toString() {
    return 'SaveAndAddMoreTimeRecordAction{navigator: $navigator, timeRecord: $timeRecord}';
  }
}

class AddOrEditTimeRecordAction {
  final TimeRecord timeRecord;

  AddOrEditTimeRecordAction(this.timeRecord);

  @override
  String toString() {
    return 'AddOrEditTimeRecordAction{timeRecord: $timeRecord}';
  }
}

class DeleteTimeRecordAction {
  final TimeRecord timeRecord;

  DeleteTimeRecordAction(this.timeRecord);

  @override
  String toString() {
    return 'DeleteTimeRecordAction{timeRecord: $timeRecord}';
  }
}
