import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/firebase_func/firebase_utils.dart';
import 'package:todo_demo/home/list/task_list_item.dart';
import 'package:todo_demo/provider/config_provider.dart';
import 'package:todo_demo/provider/list_provider.dart';

import '../../firebase_func/task.dart';
import '../../my_theme/app_colors.dart';

class Listtab extends StatefulWidget {
  @override
  State<Listtab> createState() => _ListtabState();
}

class _ListtabState extends State<Listtab> {


  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    if(listprovider.tasklist.isEmpty){
      listprovider.getAllTasksFromFireStore();
    }
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    var all = width + height ;
    var provider = Provider.of<ConfigProvider>(context);
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
            Container(
              width: double.infinity,
              height: height * 0.144,
              color: AppColors.primaryColor,
            ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: EasyDateTimeLine(
                  locale: provider.appLanguage,
                  initialDate: listprovider.selectedTime,
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                    listprovider.changeSeletedTime(selectedDate);
                  },
                  headerProps: const EasyHeaderProps(
                    showHeader: true,
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
          ],),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return  TaskListItem(task: listprovider.tasklist[index]);
              } ,
              itemCount: listprovider.tasklist.length,
            ),
          )
        ],
      ),
    );
  }





  // void getAllTasksFromFireStore_fake_false() async {
  //   try {
  //     QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
  //
  //     setState(() {
  //       tasklist = querySnapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
  //     });
  //   } catch (e) {
  //     print("Error fetching tasks: $e");
  //     // Handle error gracefully, show a message to the user, retry logic, etc.
  //   }
  // }


}
