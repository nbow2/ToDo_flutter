import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/home/list/task_list_item.dart';

import '../../my_theme/app_colors.dart';

class Listtab extends StatelessWidget {
  const Listtab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
              headerProps: const EasyHeaderProps(
                showHeader: false,
              ),
              dayProps: const EasyDayProps(
                dayStructure: DayStructure.dayStrDayNumMonth,
                activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(color: Colors.black),
                  monthStrStyle: TextStyle(color: Colors.black),
                  dayStrStyle: TextStyle(color: Colors.black),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return TaskListItem();
              } ,
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
