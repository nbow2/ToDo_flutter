import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/firebase_func/firebase_utils.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../firebase_func/task.dart';
import '../../provider/config_provider.dart';
import '../../provider/list_provider.dart';

class TaskListItem extends StatelessWidget {
  Task task ;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    var provider = Provider.of<ConfigProvider>(context);
    var list = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(13),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.70,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: (){},),
          children:  [
            SlidableAction(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
            onPressed: (context){
              FirebaseUtils.deleteTask(task).
              timeout(Duration(seconds: 1),
              onTimeout: (){
                print('task delete successfully');
                list.getAllTasksFromFireStore();
              });
            },
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)?.delete,
          ) ,
            SlidableAction(
              //borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              onPressed: (context){
                FirebaseUtils.deleteTask(task).
                timeout(Duration(seconds: 1),
                    onTimeout: (){
                      print('task Edited successfully');
                      list.getAllTasksFromFireStore();
                    });
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)?.edit,
            )
        ],
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                color: AppColors.primaryColor,
                 height: height * 0.09,
                width: width * 0.009,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      // AppLocalizations.of(context)!.title
                      task.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor
                      )
                    ),
                  Text(
                      // AppLocalizations.of(context)!.desc,
                      task.desc,
                      style:Theme.of(context).textTheme.titleMedium ,
                  )
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.010,
                    horizontal: width * 0.065),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: AppColors.primaryColor,
                ),
                child:  Icon(Icons.check, color: AppColors.white, size: 25,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
