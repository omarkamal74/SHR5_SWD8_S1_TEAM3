
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list/cubit/calander_cubit.dart';
import 'package:to_do_list/cubit/calander_state.dart';
import 'package:to_do_list/screens/home.dart';
import 'package:to_do_list/screens/overview_screen.dart';
import 'package:to_do_list/widgets/task_item_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  static  Color primaryColor = Color(0xFF2159F3);

  String getMonthName(int month) {
    var months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarCubit(),
      child: Scaffold(
        backgroundColor:  Color(0xFFF8F9FA),
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Calendar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            DateTime currentSelectedDate = DateTime.now();
            List<Map<String, dynamic>> currentTasks = [];

            if (state is CalendarUpdatedState) {
              currentSelectedDate = state.selectedDate;
              currentTasks = state.tasks;
            }

            final cubit = BlocProvider.of<CalendarCubit>(context);

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Container(
                  padding:  EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton<int>(
                            value: currentSelectedDate.month,
                            underline:  SizedBox(),
                            icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                            items: List.generate(12, (i) => i + 1).map((month) {
                              return DropdownMenuItem(
                                value: month,
                                child: Text(getMonthName(month), style: TextStyle(fontWeight: FontWeight.bold)),
                              );
                            }).toList(),
                            onChanged: (newMonth) {
                              if (newMonth != null) {
                                cubit.getTasksForDate(DateTime(currentSelectedDate.year, newMonth, currentSelectedDate.day));
                              }
                            },
                          ),
                         SizedBox(width: 24),
                          DropdownButton<int>(
                            value: currentSelectedDate.year,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                            items: List.generate(21, (i) => 2020 + i).map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text('$year', style: TextStyle(fontWeight: FontWeight.bold)),
                              );
                            }).toList(),
                            onChanged: (newYear) {
                              if (newYear != null) {
                                cubit.getTasksForDate(DateTime(newYear, currentSelectedDate.month, currentSelectedDate.day));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2040, 12, 31),
                        focusedDay: currentSelectedDate,
                        selectedDayPredicate: (day) => isSameDay(day, currentSelectedDate),
                        onDaySelected: (selectedDay, focusedDay) {
                          cubit.getTasksForDate(selectedDay);
                        },
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                          todayDecoration: BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected: ${currentSelectedDate.year}-${currentSelectedDate.month}-${currentSelectedDate.day}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Text(
                      '${currentTasks.length} tasks',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                 SizedBox(height: 12),
                currentTasks.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text('No tasks for this day', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: currentTasks.length,
                        itemBuilder: (context, index) {
                          final task = currentTasks[index];
                          return TaskItemWidget(
                            title: task['title'],
                            subtitle: task['subtitle'],
                            priority: task['priority'],
                            color: task['color'],
                          );
                        },
                      ),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (value) {
            if (value == 0) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            } else if (value == 2) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OverviewScreen()));
            }
          },
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.checklist_outlined, size: 30), label: "All"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month, size: 30), label: "Calendar"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined, size: 30), label: "Overview"),
          ],
          selectedItemColor: primaryColor,
          unselectedItemColor: Color(0xff60656b),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}