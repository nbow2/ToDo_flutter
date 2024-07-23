import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/home/list/task_list_item.dart';
import 'package:todo_demo/provider/config_provider.dart';

import '../../my_theme/app_colors.dart';

class Listtab extends StatelessWidget {
  const Listtab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConfigProvider>(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: EasyDateTimeLine(
              locale: provider.appLanguage,
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
              headerProps: const EasyHeaderProps(
                showHeader: false,

              ),
              dayProps:  EasyDayProps(
                dayStructure: DayStructure.dayStrDayNumMonth,
                borderColor: Colors.white,
                inactiveDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    color: provider.IsLightMode() ? AppColors.black : AppColors.white
                  )
                ),
                todayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    color: provider.IsLightMode() ? AppColors.black : AppColors.white
                  )
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                      color: provider.IsLightMode() ?
                      AppColors.primaryColor : AppColors.white,

                  ),
                  monthStrStyle: TextStyle(
                      color: provider.IsLightMode() ? AppColors.primaryColor : AppColors.white
                  ),
                  dayStrStyle: TextStyle(
                      color: provider.IsLightMode() ? AppColors.primaryColor : AppColors.white
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor,
                        provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return const TaskListItem();
              } ,
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
