import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/screens/main/components/error_info.dart';
import 'package:mobile_frontend/views/screens/main/components/leftover_selected_info.dart';
import 'package:mobile_frontend/views/screens/main/components/no_plan_selected_info.dart';
import 'package:mobile_frontend/views/screens/main/components/restaurant_selected_info.dart';
import 'package:mobile_frontend/views/screens/main/components/saturday_info.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../business_logic/models/selected_plan.dart';

User loggedInUser;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  CalendarController _calendarController;
  DateTime selectedDate = DateTime.now();

  Widget getInfo(SelectedPlan selectedPlan) {
    Selection selection = selectedPlan.planType;
    if (selectedPlan.isSaturday) {
      return SaturdayInfo();
    } else if (selectedPlan.isSunday) {
      return SaturdayInfo();
    } else if (selection == Selection.none) {
      return NoPlanSelectedInfo(
        date: selectedDate,
        user: loggedInUser,
      );
    } else if (selection == Selection.restaurant) {
      return RestaurantSelectedInfo(
        restaurant: selectedPlan.selectedRestaurant,
        date: selectedDate,
        user: loggedInUser,
      );
    } else {
      return LeftoverSelectedInfo(
        date: selectedDate,
        user: loggedInUser,
      );
    }
  }

  Future<SelectedPlan> getSelectedPlan(UserPlan userPlan, date) async {
    print(date);
    SelectedPlan selectedPlan = await userPlan.getPlan(date, loggedInUser);
    return selectedPlan;
  }

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
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
          onDaySelected: (date, events, holidays) {
            setState(() {
              selectedDate = date;
            });
          },
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
            child: FutureBuilder(
              future:
                  getSelectedPlan(Provider.of<UserPlan>(context), selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return ErrorInfo(
                    reload: () {
                      setState(() {});
                    },
                  );
                } else {
                  return getInfo(snapshot.data);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
