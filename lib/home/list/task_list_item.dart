import 'package:flutter/material.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    return Container(
      margin: EdgeInsets.all(13),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.white,
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
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primaryColor
                  )
                ),
              Text(
                  AppLocalizations.of(context)!.desc,
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
    );
  }
}
