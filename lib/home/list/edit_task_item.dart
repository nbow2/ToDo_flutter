import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../firebase_func/firebase_utils.dart';
import '../../firebase_func/task.dart';
import '../../my_theme/app_colors.dart';
import '../../provider/config_provider.dart';
import '../../provider/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskItem extends StatefulWidget {
  static const String routeName = 'edit_task';

  @override
  State<EditTaskItem> createState() => _EditTaskItemState();
}

class _EditTaskItemState extends State<EditTaskItem> {
  var formKEY = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String desc = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var all = height + width;
    var provider = Provider.of<ConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);

    return Stack(children: [
      Column(
        children: [],
      ),
      Container(
        width: double.infinity,
        height: height * 0.144,
        color: AppColors.primaryColor,
      ),
      Scaffold(
          appBar: AppBar(
            toolbarHeight: height * 0.18,
            title: Text(
              AppLocalizations.of(context)!.app_title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),
            elevation: 0,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
              color: provider.IsLightMode()
                  ? AppColors.white
                  : AppColors.blackDarkColor,
              borderRadius: BorderRadius.circular(all * 0.04),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKEY,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.edit,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_task_title;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (text) {
                              title = text;
                            },
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .enter_task_title,
                                hintStyle: TextStyle(
                                    color: provider.IsLightMode()
                                        ? AppColors.black
                                        : AppColors.white)),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_task_description;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (text) {
                              desc = text;
                            },
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .enter_Task_desc,
                                hintStyle: TextStyle(
                                    color: provider.IsLightMode()
                                        ? AppColors.black
                                        : AppColors.white)),
                            maxLines: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.select_time,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                showCalendar();
                              },
                              child: Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                  textAlign: TextAlign.center,
                                  style:
                                  Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.072,
                            width: width * 0.40,
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              floatingActionButton: FloatingActionButton(
                                onPressed: () {
                                  update();
                                },
                                child: Icon(Icons.tips_and_updates),
                              ),
                              floatingActionButtonLocation:
                              FloatingActionButtonLocation.centerDocked,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
    ]);
  }

  void update() {
    if (formKEY.currentState?.validate() == true) {
      // Assuming you are updating an existing task, make sure the task has a valid ID
      String taskId = 'id'; // Set this to the correct task ID

      Task task = Task(
        id: taskId,
        title: title,
        desc: desc,
        dateTime: selectedDate,
      );

      FirebaseUtils.UpdateTask(task).timeout(
        Duration(seconds: 1),
        onTimeout: () {
          print('Task updated successfully');
          listProvider.getAllTasksFromFireStore();
          Navigator.pop(context);
        },
      );
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
