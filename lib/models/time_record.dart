import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/models/models.dart';

class TimeRecord extends BaseModel {
  String workStepId;
  String workStepName;
  String description;
  TimeOfDay startTime;
  TimeOfDay endTime;
  double minutes;
  double totalTime;

  TimeRecord({
    id,
    this.workStepId,
    this.workStepName,
    this.description,
    date,
    startTime,
    endTime,
    minutes,
    totalTime,
  }) : super(id: id);

  TimeRecord.fromDynamic(Map<String, dynamic> fromDy) {
    this.id = fromDy['id'].toString();
    this.workStepId = fromDy['workStepId'].toString();
    this.workStepName = fromDy['workStepName'];
    this.startTime = TimeOfDay.fromDateTime(
        DateFormat("HH:mm:ss").parse(fromDy['startTime']));
    this.endTime =
        TimeOfDay.fromDateTime(DateFormat("HH:mm:ss").parse(fromDy['endTime']));
    this.totalTime = fromDy['totalTime'];
    this.minutes = fromDy['totalTime'];
    this.description = fromDy['description'];
  }

  TimeRecord.clone(TimeRecord timeRecordToClone) {
    this.id = timeRecordToClone.id;
    this.workStepId = timeRecordToClone.workStepId;
    this.workStepName = timeRecordToClone.workStepName;
    this.description = timeRecordToClone.description;
    this.startTime = timeRecordToClone.startTime;
    this.endTime = timeRecordToClone.endTime;
    this.minutes = timeRecordToClone.minutes;
    this.totalTime = timeRecordToClone.totalTime;
  }

  toJson() {
    if (minutes != null) {
      return {
        'workStepId': workStepId,
        'description': description,
        'minutes': minutes,
      };
    } else
      return {
        'workStepId': workStepId,
        'description': description,
        'startTime': "${startTime.hour}:${startTime.minute}",
        'endTime': "${endTime.hour}:${endTime.minute}",
      };
  }
}
