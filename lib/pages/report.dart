import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/containers/containers.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/styles/styles.dart';

class ReportPage extends StatefulWidget {
  final Function(ReportRecord) onEdit;
  final Function() onSave;
  final Function() onDelete;
  final ReportRecord report;
  final int totalMinutes;
  final List<TimeRecord> timeRecords;
  final List<MaterialRecord> materialRecords;
  final DateTime selectedDate;
  final bool editedReport;

  ReportPage(
    this.onEdit,
    this.onSave,
    this.onDelete,
    this.report,
    this.totalMinutes,
    this.timeRecords,
    this.materialRecords,
    this.selectedDate,
    this.editedReport,
  ) : super(key: Keys.reportPage);

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  final _formReportKey = GlobalKey<FormState>();
  Map _errors;
  DateTime _date;

  @override
  void initState() {
    super.initState();

    _errors = new Map();
    _errors['projectName'] = widget.report.projectName?.isEmpty ?? true;
    _date =
        widget.report.date == null ? widget.selectedDate : widget.report.date;
    widget.report.date = _date;
  }

  void _handleDayTap(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(_date.year - 1),
      lastDate: new DateTime(_date.year + 1),
    );

    if (dateTime != null) {
      widget.report.date = dateTime;
      _date = dateTime;
      widget.onEdit(widget.report);
    }
  }

  Future<bool> _onWillPop() async {
    if (widget.editedReport)
      return await showDialog(
            context: context,
            builder: (context) => SureDialog(),
          ) ??
          false;
    return Future.value(true);
  }

  Future<bool> _handleDeleteReportTap() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(Formatter.upperFirstLetter(
                AppLocalizations.of(context).deleteReport)),
            content: Text(Formatter.upperFirstLetter(
                AppLocalizations.of(context).sureToDelete)),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(Formatter.upperFirstLetter(
                    AppLocalizations.of(context).no)),
              ),
              FlatButton(
                onPressed: widget.onDelete,
                child: Text(Formatter.upperFirstLetter(
                    AppLocalizations.of(context).yes)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future _handleOnAddButtonPress() async {
    await showDialog(
      context: context,
      builder: (context) => NewProjectDialog(),
    );

    setState(() {
      _errors.update(
          'projectName', (e) => widget.report.projectName?.isEmpty ?? true);
    });
  }

  Widget _buildReportView(BuildContext context) {
    final bool shouldRenderIcon =
        widget.report.id != null && widget.report.id.isNotEmpty;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppHeader(
          icon: Icons.close,
          title: AppLocalizations.of(context).report,
          onClose: _onWillPop,
          action: shouldRenderIcon
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: _handleDeleteReportTap,
                )
              : null,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formReportKey,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  // TODO: Move this to a component
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: Styles().getInputBox,
                      child: ListTile(
                        onTap: () {
                          _handleDayTap(context);
                        },
                        leading: Icon(
                          Icons.insert_invitation,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          new DateFormat(
                            'EEEE, dd MMMM y',
                            Localizations.localeOf(context).toString(),
                          ).format(widget.report.date),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  CustomTypeAheadField(
                    id: 'projectName',
                    text: widget.report.projectName,
                    service: ProjectService().getListByName,
                    hintText: AppLocalizations.of(context).project,
                    errorText:
                        AppLocalizations.of(context).pleaseSelectCorrectProject,
                    prefixIcon: Icons.business_center,
                    suggestionWidget: (project) =>
                        ProjectTypeAheadCard(project),
                    addButton: ListProjectDTO(
                        id: AppLocalizations.of(context).addProject),
                    onAddButtonPress: _handleOnAddButtonPress,
                    onSuggestionSelected: (suggestion) {
                      widget.report.projectId = suggestion.id;
                      widget.report.projectName = suggestion.name;
                      widget.onEdit(widget.report);
                    },
                    errors: _errors,
                    showBorder: true,
                  ),
                  // TODO: Move this to a component
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: Styles().getInputBox,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.reportTimeRecords);
                        },
                        leading: Icon(
                          Icons.access_time,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              Formatter.upperFirstLetter(
                                  AppLocalizations.of(context).time),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.timeRecords.length > 0
                                ? Text(
                                    "${widget.timeRecords.length} ${widget.timeRecords.length == 1 ? AppLocalizations.of(context).entry : AppLocalizations.of(context).entries}",
                                  )
                                : null,
                          ].where(notNull).toList(),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  widget.timeRecords.length > 0
                      ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${Formatter.minutesToHMMFormat(widget.totalMinutes)} tracked for ${Formatter.listString(widget.timeRecords.map((mr) => mr.workStepName).toList(), 45)}",
                                  maxLines: null,
                                )
                              ]),
                        )
                      : null,
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: Styles().getInputBox,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.reportMaterialRecords);
                        },
                        leading: Icon(
                          Icons.build,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              Formatter.upperFirstLetter(
                                  AppLocalizations.of(context).material),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.materialRecords.length > 0
                                ? Text(
                                    "${widget.materialRecords.length} ${widget.materialRecords.length == 1 ? AppLocalizations.of(context).item : AppLocalizations.of(context).items}",
                                  )
                                : null,
                          ].where(notNull).toList(),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  widget.materialRecords.length > 0
                      ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(Formatter.listString(
                                    widget.materialRecords
                                        .map((mr) => mr.materialName)
                                        .toList(),
                                    45))
                              ]),
                        )
                      : null,
                ].where(notNull).toList(),
              ),
            ),
          ),
        ),
        floatingActionButton: BottomButtonsDetailsPage(
          disabled: _errors.containsValue(true),
          onTapBottom: widget.onSave,
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLoading(
      builder: (context, loading) =>
          loading ? LoadingIndicator() : _buildReportView(context),
    );
  }
}
