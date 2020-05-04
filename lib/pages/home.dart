import 'package:flutter/material.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/containers/containers.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/styles/styles.dart';

class HomePage extends StatelessWidget {
  final Function(DragEndDetails) onHorizontalDrag;
  final List<ReportRecord> reports;
  final Function() onAddReportTap;
  final Function(ReportRecord) onReportTap;

  HomePage({
    @required this.onHorizontalDrag,
    @required this.reports,
    @required this.onAddReportTap,
    @required this.onReportTap,
  }) : super(key: Keys.loginPage);

  ListView _buildReportListView() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 60),
      itemCount: reports.length,
      itemBuilder: (BuildContext context, int index) {
        final report = reports[index];

        return InkWell(
          onTap: () {
            this.onReportTap(report);
            Navigator.of(context).pushNamed(Routes.report);
          },
          child: Container(
            margin: EdgeInsets.all(15),
            decoration: Styles().getReportContainer,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${report.projectName}",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${report.customerName}",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.schedule,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              Formatter.upperFirstLetter(
                                  AppLocalizations.of(context).time),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Text(
                          "${report.timeRecords.length == 0 ? 0 : Formatter.doubleMinutesToHMMFormat(report.timeRecords.fold(0, (curr, next) => curr + next.totalTime))} in ${report.timeRecords.length} ${report.timeRecords.length == 1 ? AppLocalizations.of(context).report : AppLocalizations.of(context).reports}",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.build,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              Formatter.upperFirstLetter(
                                  AppLocalizations.of(context).material),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Text(
                          "${report.materialRecords.length} ${report.materialRecords.length == 1 ? AppLocalizations.of(context).item : AppLocalizations.of(context).items}",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: HomeHeader(),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) =>
              onHorizontalDrag(details),
          child: AppLoading(
            builder: (context, loading) =>
                loading ? LoadingIndicator() : _buildReportListView(),
          ),
        ),
        backgroundColor: Styles().getReportPageBackgroundColor,
        floatingActionButton: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width - 40,
          buttonColor: Styles().getButtonColor,
          shape: Styles().getButtonThemeShape,
          child: RaisedButton(
            onPressed: () {
              onAddReportTap();
              Navigator.pushNamed(context, Routes.report);
            },
            child: Text(
              AppLocalizations.of(context).createReport.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
