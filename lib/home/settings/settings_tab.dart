import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/home/settings/language_sheet.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:todo_demo/provider/config_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    var all = height + width ;
    var provider = Provider.of<ConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(all * 0.010),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.labelLarge,),
          SizedBox(height: height * 0.020,),
          InkWell(
            onTap: (){
              ShowBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(all * 0.010),
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'ar' ?
                    AppLocalizations.of(context)!.arabic:
                    AppLocalizations.of(context)!.english,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Icon(
                    Icons.arrow_drop_down ,
                    size: all * 0.03,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),

    );
  }

  void ShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageSheet());
  }
}
