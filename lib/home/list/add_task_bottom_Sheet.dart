import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/firebase_func/firebase_utils.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_demo/provider/config_provider.dart';
import 'package:todo_demo/provider/list_provider.dart';

import '../../firebase_func/task.dart';
import '../../provider/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKEY =GlobalKey<FormState>() ;
  var selectedDate = DateTime.now() ;
  String title = '';
  String desc = '';
  late ListProvider listProvider ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    var provider = Provider.of<ConfigProvider>(context);
     listProvider = Provider.of<ListProvider>(context);
    return Container(
      height: double.infinity,
     width: double.infinity,
     margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.add_task,
            textAlign: TextAlign.center ,
          style: Theme.of(context).textTheme.titleMedium,),
          Form(
              key: formKEY,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              TextFormField(
                validator: (text){
                  if (text == null || text.isEmpty) {
                     return AppLocalizations.of(context)!.please_enter_task_title;
                  } else {
                    return null ;
                  }
                },
                onChanged: (text){
                  title = text;
                },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task_title,
                    hintStyle: TextStyle(
                        color: provider.IsLightMode() ?
                        AppColors.black :
                        AppColors.white
                    )
                ),

              ),
              SizedBox(height: height* 0.02,),
              TextFormField(
                validator:(text){
                  if (text == null || text.isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_task_description;
                  } else {
                    return null ;
                  }
                } ,
                onChanged: (text){
                  desc = text ;
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_Task_desc,
                  hintStyle: TextStyle(
                    color: provider.IsLightMode() ?
                    AppColors.black :
                    AppColors.white
                  )
                ),
                maxLines: 3,

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.select_time ,
                  textAlign: TextAlign.start ,
                  style: Theme.of(context).textTheme.bodyLarge,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: (){
                    ShowCalender();
                  },
                  child: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium ),
                ),
              ),
              SizedBox(
                height: height *0.072,
                width: width * 0.08,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  floatingActionButton: FloatingActionButton(
                    onPressed: (){
                      addTask();
                    },
                    child: Icon(Icons.check),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

                ),
              )
            ],
          ))


        ],
      ),

    );
  }

  void addTask() {

    if(formKEY.currentState?.validate() == true)
    {
      // add Task
      Task task = Task(
          title: title,
          desc: desc,
          dateTime: selectedDate
      );
      FirebaseUtils.addTask(task).timeout(
          Duration(seconds: 1),
          onTimeout: (){
            print('task added successfully');
            listProvider.getAllTasksFromFireStore();
            Navigator.pop(context);
          }
      );
    }
  }

  void ShowCalender() async{
   var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
   selectedDate = chosenDate ?? selectedDate ;
   setState(() {

   });
  }
}
