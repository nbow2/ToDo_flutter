import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/home/list/add_task_bottom_Sheet.dart';
import 'package:todo_demo/home/list/listtab.dart';
import 'package:todo_demo/home/settings/settings_tab.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/config_provider.dart';


class Homescreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int SelectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width  = MediaQuery.of(context).size.width ;
    var all = width + height ;
    var provider = Provider.of<ConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height *0.08,
        title: Text(AppLocalizations.of(context)!.app_title,
        style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
      ),
      body: tabs[SelectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: provider.IsLightMode() ? AppColors.white : AppColors.blackDarkColor,
        height: all * 0.07  ,
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            onTap: (index){
              SelectedIndex = index ;
              setState(() {
          
              });
            },
            currentIndex: SelectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list, size: 35,),
                  label:'',
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.settings ,size: 35,),
                  label: '',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addTaskSheet();
        },
        child: Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

  List<Widget> tabs = [Listtab(),SettingsTab()];

  void addTaskSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddTaskBottomSheet());
  }
}
