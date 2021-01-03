import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/views/screens/main/components/leftover_selected_info.dart';
import 'package:mobile_frontend/views/screens/main/components/no_plan_selected_info.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CalendarController _calendarController;

  Widget getInfo(Selection selectedPlan) {
    if (selectedPlan == Selection.none) {
      return NoPlanSelectedInfo();
    } else {
      return LeftoverSelectedInfo();
    }
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TableCalendar(
          calendarController: _calendarController,
          initialCalendarFormat: CalendarFormat.week,
          formatAnimation: FormatAnimation.slide,
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 15.0,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15.0,
            ),
            leftChevronMargin: EdgeInsets.only(left: 70.0),
            rightChevronMargin: EdgeInsets.only(right: 70.0),
          ),
          calendarStyle: CalendarStyle(
            weekendStyle: TextStyle(color: Colors.white),
            weekdayStyle: TextStyle(color: Colors.white),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.white),
            weekdayStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
              color: Colors.white,
            ),
            child: getInfo(Provider.of<SelectedPlan>(context).selectedPlan),
          ),
        ),
      ],
    );
  }
}
