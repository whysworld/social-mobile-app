import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/styles/styles.dart';

class TimeRecordsPage extends StatefulWidget {
  final Function onTapTimeRecord;
  final Function onTapDeleteTimeRecord;
  final DateTime date;
  final int todayWorkTime;
  final List<TimeRecord> timeRecords;
  final bool trackHours;
  final int quantityTimeRecords;

  TimeRecordsPage(
    this.onTapTimeRecord,
    this.onTapDeleteTimeRecord,
    this.date,
    this.todayWorkTime,
    this.trackHours,
    this.timeRecords,
    this.quantityTimeRecords,
  ) : super(key: Keys.timeRecordsPage);

  @override
  _TimeRecordsPageState createState() => new _TimeRecordsPageState();
}

class _TimeRecordsPageState extends State<TimeRecordsPage> {
  bool _deleteMode;

  @override
  void initState() {
    super.initState();

    _deleteMode = false;
  }

  ListView _buildListTimeRecordsView() {
    return ListView.builder(
      itemCount: widget.timeRecords.length,
      itemBuilder: (BuildContext context, int index) {
        final timeRecord = widget.timeRecords[index];

        return Row(
          children: <Widget>[
            _deleteMode
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      widget.onTapDeleteTimeRecord(timeRecord);
                    },
                  )
                : null,
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: Styles().getInputBoxNoBorder,
                  child: ListTile(
                    onTap: () {
                      widget.onTapTimeRecord(timeRecord);
                      Navigator.of(context).pushNamed(Routes.timeRecordDetails);
                    },
                    leading: Icon(
                      Icons.timer,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          timeRecord.workStepName,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(!widget.trackHours
                            ? "${Formatter.timeOfDayToString(timeRecord.startTime)} - ${Formatter.timeOfDayToString(timeRecord.endTime)}"
                            : Formatter.doubleMinutesToHMMFormat(
                                    timeRecord.minutes == null
                                        ? timeRecord.totalTime
                                        : timeRecord.minutes)
                                .toString())
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ].where(notNull).toList(),
        );
      },
    );
  }

  void handleEditModeTap() {
    setState(() {
      _deleteMode = !_deleteMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppHeader(
          title: AppLocalizations.of(context).time,
          action: IconButton(
            icon: Icon(
              _deleteMode ? Icons.check : Icons.edit,
              color: Colors.red,
            ),
            onPressed: handleEditModeTap,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: new Border.all(color: Colors.grey, width: 0.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                            "${Formatter.upperFirstLetter(AppLocalizations.of(context).workingTimeOn)} ${new DateFormat('EEEE, dd MMMM y', Localizations.localeOf(context).toString()).format(widget.date)}"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "${Formatter.minutesToHMMFormat(widget.todayWorkTime)}",
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15),
                        child: Text(
                            "${widget.quantityTimeRecords} ${widget.quantityTimeRecords == 1 ? AppLocalizations.of(context).entry : AppLocalizations.of(context).entries}"),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _buildListTimeRecordsView(),
              )
            ],
          ),
        ),
        floatingActionButton: ButtonTheme(
          buttonColor: Styles().getButtonColor,
          shape: Styles().getButtonThemeShape,
          minWidth: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            onPressed: () {
              widget.onTapTimeRecord(new TimeRecord());
              Navigator.of(context).pushNamed(Routes.timeRecordDetails);
            },
            child: Text(
              AppLocalizations.of(context).addTimeEntry.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
