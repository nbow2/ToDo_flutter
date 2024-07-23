import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/home/list/add_task_bottom_Sheet.dart';
import 'package:todo_demo/home/list/listtab.dart';
import 'package:todo_demo/home/settings/settings_tab.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height *0.184,
        title: Text(AppLocalizations.of(context)!.app_title,
        style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
      ),
      body: tabs[SelectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: 83  ,
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
