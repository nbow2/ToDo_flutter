import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/firebase_func/firebase_utils.dart';
import 'package:todo_demo/home/list/edit_task_item.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../firebase_func/task.dart';
import '../../provider/config_provider.dart';
import '../../provider/list_provider.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ConfigProvider>(context);
    var list = Provider.of<ListProvider>(context);

    Color getBackgroundColor() {
      if (widget.task.isDone) {
        return provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor;
      }
      return provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor;
    }

    Color getTitleColor() {
      if (widget.task.isDone) {
        return Colors.green; // Adjust this to the green color you use for completed tasks
      }
      return provider.IsLightMode() ? AppColors.primaryColor : AppColors.primaryColor;
    }

    return Container(
      margin: EdgeInsets.all(13),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.70,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {},),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              onPressed: (context) {
                FirebaseUtils.deleteTask(widget.task).timeout(
                    Duration(seconds: 1),
                    onTimeout: () {
                      print('Task deleted successfully');
                      list.getAllTasksFromFireStore();
                    }
                );
              },
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)?.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditTaskItem())
                );
                FirebaseUtils.UpdateTask(widget.task).timeout(
                    Duration(seconds: 1),
                    onTimeout: () {
                      print('Task updated successfully');
                      list.getAllTasksFromFireStore();
                    }
                );
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)?.edit,
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                color: widget.task.isDone ? Colors.green : AppColors.primaryColor,
                height: height * 0.09,
                width: width * 0.009,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: getTitleColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.task.desc ,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: provider.IsLightMode() ?AppColors.black :AppColors.white,
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.010,
                    horizontal: width * 0.065
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: widget.task.isDone ? Colors.green : AppColors.primaryColor,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.task.isDone = !widget.task.isDone;
                    });
                    FirebaseUtils.UpdateTask_isDone(widget.task);
                  },
                  child: widget.task.isDone
                      ? Text(
                    'Done!',
                    style: TextStyle(
                      color: Colors.white, // Ensure "Done!" text is always visible
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
