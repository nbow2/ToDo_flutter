import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:todo_demo/provider/config_provider.dart';
class ThemeSheet extends StatefulWidget {
  const ThemeSheet({super.key});

  @override
  State<ThemeSheet> createState() => _ThemeSheetState();
}

class _ThemeSheetState extends State<ThemeSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    var all = height + width ;
    var provider = Provider.of<ConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(all * 0.012),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                provider.ChangeTheme(ThemeMode.light);
              },
              child: provider.Theme == ThemeMode.light ?
              getSelectedItem(AppLocalizations.of(context)!.light_theme):
              getUnselectedItem(AppLocalizations.of(context)!.light_theme)
          ),
          SizedBox(height: all * 0.012,),
          InkWell(
            onTap: (){
              provider.ChangeTheme(ThemeMode.dark);
            },
            child: provider.IsDarkMode() ?
            getSelectedItem(AppLocalizations.of(context)!.dark_theme):
            getUnselectedItem(AppLocalizations.of(context)!.dark_theme),
          )
        ],
      ),
    );
  }

  Widget getSelectedItem(text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style:Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primaryColor
          ) ,
        ),
        Icon(Icons.check , color: AppColors.primaryColor)
      ],
    ) ;
  }

  Widget getUnselectedItem(String text){
    return Row(
      children: [
        Text(
          text,
          style:Theme.of(context).textTheme.labelLarge,),
      ],
    );
  }
}
