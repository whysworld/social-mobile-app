import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'header_tab_bar.dart';

class Header extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Function onLanguageChangeSelected;
  final int todayTotalTimeInMinutes;
  final int thisWeekTotalTimeInMinutes;
  final Map<DateTime, List> reportCount;

  Header({
    Key key,
    @required this.selectedDate,
    @required this.onDateSelected,
    @required this.onLanguageChangeSelected,
    @required this.todayTotalTimeInMinutes,
    @required this.thisWeekTotalTimeInMinutes,
    @required this.reportCount,
  }) : super(key: key ?? Keys.header);

  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  final now = DateTime.now();
  final today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final yesterday = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  TabController _tabController;
  String _languageCode;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(selectedIndex());
    return AppBar(
      title: Text(
        'Tracksite',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 27,
          fontFamily: 'Arciform',
        ),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Styles().getAppBarColor,
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (selected) async {
            switch (selected) {
              case 0:
                await CustomerSharedPrefernces.removeValue("token");
                await CustomerSharedPrefernces.removeValue("refreshToken");
                break;
              case 1:
                launchPrivacyPolicy();
                break;
              case 2:
                showLanguageDialog();
                break;
              default:
                break;
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 2,
                child: Text(AppLocalizations.of(context).changeLanguage),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(Formatter.upperFirstLetter(
                    AppLocalizations.of(context).privacy)),
              ),
              PopupMenuItem(
                value: 0,
                child: Text(AppLocalizations.of(context).logOut),
              ),
            ];
          },
        )
      ],
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: 85, left: 12, right: 12, bottom: 65),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            HeaderInfo(
              title: AppLocalizations.of(context).today,
              minutes: widget.todayTotalTimeInMinutes,
            ),
            Divider(
              indent: 8,
            ),
            HeaderInfo(
              title: AppLocalizations.of(context).thisWeek,
              minutes: widget.thisWeekTotalTimeInMinutes,
            ),
          ],
        ),
      ),
      bottom: HeaderTabBar(
        child: TabBar(
          controller: _tabController,
          onTap: (tap) {
            switch (tap) {
              case 0:
                widget.onDateSelected(yesterday);
                break;
              case 1:
                widget.onDateSelected(today);
                break;
              case 2:
                handleDayTap(context);
                break;
            }
          },
          tabs: [
            Tab(
              child: Text(AppLocalizations.of(context).yesterday.toUpperCase(),
                  style: TextStyle(
                      color: selectedIndex() != 0 ? Colors.grey : Colors.red)),
            ),
            Tab(
              child: Text(AppLocalizations.of(context).today.toUpperCase(),
                  style: TextStyle(
                      color: selectedIndex() != 1 ? Colors.grey : Colors.red)),
            ),
            Tab(
              child: selectedIndex() == 2
                  ? Text(
                      DateFormat(
                        'EE dd MMMM y',
                        Localizations.localeOf(context).toString(),
                      ).format(widget.selectedDate),
                      style: TextStyle(color: Colors.red),
                    )
                  : Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  int selectedIndex() {
    DateTime aDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);
    if (aDate == today) {
      return 1;
    } else if (aDate == yesterday) {
      return 0;
    } else {
      return 2;
    }
  }

  void handleDayTap(BuildContext context) async {
    DateTime dateTime = await showDialog(
      context: context,
      builder: (context) => CalendarDialog(
        events: widget.reportCount,
        selectedDate: widget.selectedDate,
      ),
    );

    if (dateTime != null)
      widget.onDateSelected(dateTime);
    else
      _tabController.animateTo(selectedIndex());
  }

  void launchPrivacyPolicy() async {
    final String url = GlobalConfiguration().getString("policyUrl");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void showLanguageDialog() {
    _languageCode = AppLocalizations.of(context).locale.languageCode;
    showDialog(
      context: context,
      builder: (context) => LanguageDialog(
        languageCode: _languageCode,
        onChanged: _handleRadioValueChange,
      ),
    );
  }

  void _handleRadioValueChange(String value) {
    setState(() {
      _languageCode = value;
      widget.onLanguageChangeSelected(_languageCode);
    });
  }
}
