// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:userapp/Constant/ConstantValues.dart';

final List<int> scheduleDays = [15];
final List<int> leaveDays = [26];

class Schedule extends StatefulWidget {
  void Function(List<String>) onTapList;
  Schedule({
    Key? key,
    required this.onTapList,
  }) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  // CalendarFormat style = CalendarFormat.twoWeeks;

  bool toDateSelected = false;
  DateTime currentTime = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle =
        TextStyle(color: primarySwatch[400]!, fontSize: 14);
    final double dotWidth = 8;
    final double rowHeight = 40;
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height * .78,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Container(
                  // height: MediaQuery.of(context).size.width,
                  child: TableCalendar(
                onDaySelected: (d, dt) {
                  setState(() {
                    if (toDateSelected) {
                      toDateSelected = false;
                      toDate = d;
                    } else {
                      toDateSelected = true;
                      fromDate = d;
                    }
                    if (fromDate.microsecondsSinceEpoch >
                        toDate.microsecondsSinceEpoch) {
                      DateTime olddate = fromDate;
                      fromDate = toDate;
                      toDate = olddate;
                    }
                  });
                },
                daysOfWeekHeight: 50,
                daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
                rangeStartDay: fromDate,
                rangeEndDay: toDate,
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, d) {
                    return Container(
                        decoration: BoxDecoration(
                          color: primarySwatch[100],
                        ),
                        child: Center(
                            child: Text(
                          weekDays[d.weekday]!,
                          style: TextStyle(
                            color: primarySwatch[900],
                            fontSize: 14,
                          ),
                        )));
                  },
                ),
                focusedDay: toDate,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                calendarStyle: CalendarStyle(
                    rangeHighlightColor: primarySwatch[300]!,
                    rangeStartTextStyle: TextStyle(color: Colors.white),
                    withinRangeTextStyle: TextStyle(color: Colors.white),
                    rangeStartDecoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    rangeEndDecoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    rangeEndTextStyle: TextStyle(color: Colors.white)),
                headerStyle: HeaderStyle(
                  headerPadding: EdgeInsets.zero,
                  titleTextStyle: Theme.of(context).textTheme.bodyText1!,
                  formatButtonVisible: false,
                  titleCentered: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  rightChevronMargin: EdgeInsets.zero,
                  leftChevronMargin: EdgeInsets.zero,
                  leftChevronPadding: EdgeInsets.zero,
                  rightChevronPadding: EdgeInsets.zero,
                  headerMargin: EdgeInsets.only(bottom: 10),
                ),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                var timefrom = DateFormat('yyyy-MM-dd').format(fromDate);
                var timeto = DateFormat('yyyy-MM-dd').format(toDate);

                widget.onTapList([timefrom, timeto]);
                // log('ff' + timefrom.toString());
                // log('ff' + timeto.toString());

                Navigator.pop(context);
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
                  color: primaryColor,
                ),
                child: Center(
                  child: Text(
                    'Apply Filter',
                    style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

Map<int, String> weekDays = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun"
};
/*
TableCalendar(
                  
                    currentDay: currentTime,
                    onDaySelected: (d, da) {
                      setState(() {
                        currentTime = da;
                      });
                    },
                    eventLoader: (data) {
                      if (scheduleDays.contains(data.day)) {
                        return <int>[1];
                      }
                      if (leaveDays.contains(data.day)) {
                        if (data.isAfter(DateTime.now())) {
                          return [];
                        }
                        return <int>[0];
                      }
                      return [];
                    },
                    rangeSelectionMode: RangeSelectionMode.toggledOn,
                    // pageAnimationEnabled: false,
                    // pageJumpingEnabled: false,
                    rangeStartDay: DateTime(2021, 12, 31),
                    rangeEndDay: DateTime(2021, 12, 18),
                    dayHitTestBehavior: HitTestBehavior.deferToChild,
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (con, d, data) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                              child: Text(
                            "${d.day}",
                            style: defaultTextStyle.copyWith(
                                color: d.isAfter(DateTime.now())
                                    ? primarySwatch[600]
                                    : primarySwatch[300]),
                          )),
                        );
                      },
                      // dowBuilder: (context, d) {
                      //   return Container(
                      //       decoration:
                      //           BoxDecoration(color: primarySwatch[100]),
                      //       child: Center(
                      //           child: Text(
                      //         weekDays[d.weekday]!,
                      //         style: TextStyle(
                      //           color: primarySwatch[900],
                      //           fontSize: 14,
                      //         ),
                      //       )));
                      // },
                      outsideBuilder: (context, d, data) {
                        return Center(
                            child: Text(
                          "${d.day}",
                          style: defaultTextStyle.copyWith(
                              color: Colors.grey.withOpacity(.5)),
                        ));
                      },

                      markerBuilder: (context, d, data) {
                        if (data.isEmpty) return SizedBox();
                        // return Text(d.day.toString());
                        return Center(
                          child: Container(
                            height: rowHeight - 10,
                            width: rowHeight - 10,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              border: Border(
                                  bottom: BorderSide(
                                      color: data[0] == 0
                                          ? Colors.red
                                          : Colors.green)),
                              // color: data[0] == 0 ? Colors.red : Colors.green,
                            ),
                            // height: dotWidth,
                            // width: dotWidth,
                          ),
                        );
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Card(
                            margin: EdgeInsets.all(0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10000),
                              // side: BorderSide(color: Colors.red),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: data[0] == 0 ? Colors.red : Colors.green,
                              ),
                              height: dotWidth,
                              width: dotWidth,
                            ),
                          ),
                        );
                      },
                      selectedBuilder: (context, d, date) {
                        return Container(
                          color: Colors.pink,
                          height: 10,
                          width: 10,
                        );
                      },
                      todayBuilder: (context, d, data) {
                        return Container(
                          height: rowHeight - 10,
                          width: rowHeight - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // shape: BoxShape.circle,
                              color: primarySwatch[100]),
                          child: Center(
                            child: Text(
                              d.day.toString(),
                              style: defaultTextStyle.copyWith(
                                color: primarySwatch[900],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    headerStyle: HeaderStyle(
                      headerPadding: EdgeInsets.zero,
                      titleTextStyle: Theme.of(context).textTheme.bodyText1!,
                      formatButtonVisible: false,
                      titleCentered: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      rightChevronMargin: EdgeInsets.zero,
                      leftChevronMargin: EdgeInsets.zero,
                      leftChevronPadding: EdgeInsets.zero,
                      // leftChevronIcon: Icon(
                      //   Icons.chevron_left,
                      //   size: 30,
                      //   color: primarySwatch[900],
                      // ),
                      // rightChevronIcon: Icon(
                      //   Icons.chevron_right,
                      //   size: 30,
                      //   color: primarySwatch[900],
                      // ),
                      rightChevronPadding: EdgeInsets.zero,
                      headerMargin: EdgeInsets.only(bottom: 10),
                    ),
                    calendarStyle: CalendarStyle(
                      markerDecoration: BoxDecoration(color: Colors.red),
                      markerSize: 4,
                      cellPadding: EdgeInsets.zero,
                      markersAutoAligned: true,
                      // weekendTextStyle:
                      //     defaultTextStyle.copyWith(color: Colors.black),
                      // weekendDecoration: BoxDecoration(color: Colors.black),
                      holidayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primarySwatch[700]!)),
                      holidayTextStyle: TextStyle(color: primarySwatch[400]),
                      cellMargin: EdgeInsets.zero,
                    ),
                    rowHeight: rowHeight,
                    daysOfWeekHeight: 40,
                    // daysOfWeekHeight: 50,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: primarySwatch[900],
                        fontWeight: FontWeight.w300,
                      ),
                      weekendStyle: TextStyle(
                        color: primarySwatch[900],
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: BoxDecoration(
                        color: primarySwatch[100],
                        border: Border.all(
                          color: primarySwatch[900]!,
                          width: .2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    daysOfWeekVisible: true,
                    // holidayPredicate: (d) {
                    //   return d.day == (DateTime.now().day + 1);
                    // },
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    focusedDay: currentTime,
                    firstDay: DateTime.utc(2015),
                    lastDay: DateTime.utc(2024)),
             
*/
