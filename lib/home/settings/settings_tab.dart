import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:todo_demo/provider/config_provider.dart';
import 'package:todo_demo/home/settings/theme_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_demo/home/settings/language_sheet.dart';

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
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.085,
            color: AppColors.primaryColor,
          ),
          Container(
            margin: EdgeInsets.all(all * 0.010) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.labelLarge,),
                SizedBox(height: height * 0.020,),
                InkWell(
                  onTap: (){
                    ShowBottomSheetLanguage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(all * 0.010),
                    decoration: BoxDecoration(
                      color: provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor,
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
                ),
                SizedBox(height: height * 0.020,),
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: Theme.of(context).textTheme.labelLarge,),
                SizedBox(height: height * 0.020,),
                InkWell(
                  onTap: (){
                    ShowBottomSheetTheme();
                  },
                  child: Container(
                    padding: EdgeInsets.all(all * 0.010),
                    decoration: BoxDecoration(
                      color: provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider.IsLightMode() ?
                          AppLocalizations.of(context)!.light_theme:
                          AppLocalizations.of(context)!.dark_theme,
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
          ),
        ],
      ),

    );
  }

  void ShowBottomSheetLanguage() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageSheet());
  }

  void ShowBottomSheetTheme() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ThemeSheet());
  }
}
