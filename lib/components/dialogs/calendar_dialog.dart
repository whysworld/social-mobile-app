import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tracksite/helpers/helpers.dart';

class CalendarDialog extends StatelessWidget {
  final Map<DateTime, List> events;
  final DateTime selectedDate;

  CalendarDialog({Key key, this.events, this.selectedDate})
      : super(key: key ?? Keys.calendarDialog);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Material(
        child: TableCalendar(
          locale: AppLocalizations.of(context).locale.toLanguageTag(),
          events: events,
          selectedDay: selectedDate,
          initialCalendarFormat: CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          builders: CalendarBuilders(
            markersBuilder: (context, date, events, holidays) {
              final children = <Widget>[];

              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: _buildEventsMarker(date, events),
                  ),
                );
              }

              return children;
            },
          ),
          calendarStyle: CalendarStyle(
            selectedColor: Colors.deepOrange[400],
            todayColor: Colors.deepOrange[200],
            markersColor: Colors.brown[700],
          ),
          headerStyle: HeaderStyle(
            formatButtonTextStyle:
                TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
            formatButtonDecoration: BoxDecoration(
              color: Colors.deepOrange[400],
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onDaySelected: (DateTime date, List<dynamic> events) {
            Navigator.of(context).pop(date);
          },
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.brown[500],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
