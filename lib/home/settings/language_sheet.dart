import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:todo_demo/provider/config_provider.dart';
class LanguageSheet extends StatefulWidget {
  const LanguageSheet({super.key});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
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
            provider.ChangeLanguage('ar');
            },
            child: provider.appLanguage == 'ar' ?
            getSelectedItem(AppLocalizations.of(context)!.arabic):
            getUnselectedItem(AppLocalizations.of(context)!.arabic)
          ),
          SizedBox(height: all * 0.012,),
          InkWell(
            onTap: (){
              provider.ChangeLanguage('en');
            },
            child: provider.appLanguage == 'en' ?
            getSelectedItem(AppLocalizations.of(context)!.english):
            getUnselectedItem(AppLocalizations.of(context)!.english),
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
