import 'package:flutter/material.dart';
import 'package:todo_demo/my_theme/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKEY =GlobalKey<FormState>() ;
  var dateTime = DateTime.now() ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    return Container(
      height: double.infinity,
     width: double.infinity,
     margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Text('Add New Task',
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
                     return 'Please enter task title';
                  } else {
                    return null ;
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter Task Title'
                ),

              ),
              SizedBox(height: height* 0.02,),
              TextFormField(
                validator:(text){
                  if (text == null || text.isEmpty) {
                    return 'Please enter task Description';
                  } else {
                    return null ;
                  }
                } ,
                decoration: InputDecoration(
                  hintText: 'Enter Task Description',
                ),
                maxLines: 3,

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select Time' ,
                  textAlign: TextAlign.start ,
                  style: Theme.of(context).textTheme.bodyLarge,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: (){
                    ShowCalender();
                  },
                  child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium ),
                ),
              ),
              SizedBox(
                height: height *0.082,
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

    }
  }

  void ShowCalender() async{
   var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
   dateTime = chosenDate ?? dateTime ;
   setState(() {

   });
  }
}
