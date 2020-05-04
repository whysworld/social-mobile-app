import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/styles/styles.dart';

class TimeRecordDetailsPage extends StatefulWidget {
  final Function(TimeRecord) onSave;
  final Function(TimeRecord) onSaveAndContinue;
  final bool trackHours;
  final TimeRecord timeRecord;

  TimeRecordDetailsPage(
      this.onSave, this.onSaveAndContinue, this.trackHours, this.timeRecord)
      : super(key: Keys.timeRecordDetailsPage);

  @override
  TimeRecordDetailsPageState createState() => TimeRecordDetailsPageState();
}

class TimeRecordDetailsPageState extends State<TimeRecordDetailsPage> {
  Map _errors;

  @override
  void initState() {
    super.initState();

    _errors = new Map();
    _errors['workstepName'] = widget.timeRecord.workStepName?.isEmpty ?? true;
    if (!widget.trackHours) {
      _errors['from'] = widget.timeRecord.startTime == null;
      _errors['to'] = widget.timeRecord.endTime == null;
    } else
      _errors['totalTime'] = widget.timeRecord.totalTime == null;
  }

  bool get invalidTime {
    if (widget.trackHours)
      return widget.timeRecord.minutes <= 0;
    else
      return widget.timeRecord.startTime != null &&
          widget.timeRecord.endTime != null &&
          Formatter.totalMinutes(widget.timeRecord.endTime) <=
              Formatter.totalMinutes(widget.timeRecord.startTime);
  }

  Widget typeOfTimeSelector() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: !widget.trackHours
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: CustomTimeSelectorField(
                        id: 'from',
                        hintText: Formatter.upperFirstLetter(
                            AppLocalizations.of(context).from),
                        initialValue: widget.timeRecord.startTime,
                        onChanged: (from) {
                          setState(() {
                            widget.timeRecord.startTime = from;
                          });
                        },
                        errorText:
                            AppLocalizations.of(context).pleaseInputCorrectHour,
                        errors: _errors,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Divider(),
                    ),
                    Flexible(
                      child: CustomTimeSelectorField(
                        id: 'to',
                        hintText: Formatter.upperFirstLetter(
                            AppLocalizations.of(context).to),
                        initialValue: widget.timeRecord.endTime,
                        onChanged: (to) {
                          setState(() {
                            widget.timeRecord.endTime = to;
                          });
                        },
                        errorText:
                            AppLocalizations.of(context).pleaseInputCorrectHour,
                        errors: _errors,
                      ),
                    ),
                  ],
                ),
                invalidTime
                    ? Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Container(
                          decoration: Styles().getInputBoxNoBorder,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              Formatter.upperFirstLetter(
                                  AppLocalizations.of(context)
                                      .startTimeBiggerEndTime),
                              style: Styles().getErrorTextStyles,
                            ),
                          ),
                        ),
                      )
                    : null
              ].where(notNull).toList(),
            )
          : CustomTimeSelectorField(
              id: 'totalTime',
              hintText: AppLocalizations.of(context).numberOfHours,
              initialValue: Formatter.minutesToTimeOfDay(
                  widget.timeRecord.minutes ?? widget.timeRecord.totalTime),
              onChanged: (minutes) {
                setState(() {
                  widget.timeRecord.minutes =
                      Formatter.totalMinutes(minutes).toDouble();
                });
              },
              errorText: AppLocalizations.of(context).pleaseInputCorrectHour,
              errors: _errors,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppHeader(
          title: AppLocalizations.of(context).timeEntry,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomTypeAheadField(
                          id: 'workstepName',
                          text: widget.timeRecord.workStepName,
                          service: WorkStepService().getListByName,
                          hintText: AppLocalizations.of(context).workstep,
                          errorText: AppLocalizations.of(context)
                              .pleaseSelectCorrectProject,
                          prefixIcon: Icons.assignment,
                          suggestionWidget: (workstep) =>
                              ListTile(title: Text(workstep.name)),
                          onSuggestionSelected: (workstep) {
                            widget.timeRecord.workStepId = workstep.id;
                            widget.timeRecord.workStepName = workstep.name;
                          },
                          errors: _errors,
                        ),
                        typeOfTimeSelector(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                            decoration: Styles().getInputBoxNoBorder,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: FormKeyboardActions(
                                autoScroll: true,
                                child: CustomKeyboard(
                                  description: widget.timeRecord.description,
                                  onChange: (value) {
                                    widget.timeRecord.description = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].where(notNull).toList(),
                    ),
                  ),
                ),
                BottomButtonsDetailsPage(
                  disabled: _errors.containsValue(true) || invalidTime,
                  onTapTop: () => widget.onSaveAndContinue(widget.timeRecord),
                  onTapBottom: () => widget.onSave(widget.timeRecord),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
