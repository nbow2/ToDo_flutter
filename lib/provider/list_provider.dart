import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_func/firebase_utils.dart';
import '../firebase_func/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasklist = [];
  DateTime selectedTime = DateTime.now();

  void getAllTasksFromFireStore()async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
    //
    tasklist = querySnapshot.docs.map((doc) {return doc.data();}).toList();
    // this is how to filter all tasks by Date Time
    // like if u crate task at 20/10/2024 it only show on that date not in any else time
    tasklist = tasklist.where((task){
      if(selectedTime.day == task.dateTime.day &&
         selectedTime.month == task.dateTime.month &&
         selectedTime.year == task.dateTime.year ){
        return true ;
      }
      return false ;
    }).toList();

    // sorting the tasks
    tasklist.sort((Task task, Task task1){
      return task.dateTime.compareTo(task1.dateTime) ;
    });

    notifyListeners();
  }

  void changeSeletedTime(DateTime NewDate){
    selectedTime = NewDate ;
    getAllTasksFromFireStore();
  }
}