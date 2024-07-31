import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_demo/firebase_func/task.dart';

class FirebaseUtils{
  static CollectionReference<Task> getTasksCollection(){
    return FirebaseFirestore.instance.collection(Task.collectNameData).
    withConverter<Task>(
        fromFirestore: (snapshot ,options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (task, options) => task.toFireStore()
    );
  }
  // add task
  static Future<void> addTask(Task task) {
    var taskCollection = getTasksCollection();
    DocumentReference<Task> taskDocRef =  taskCollection.doc(); // to crate Document
    task.id = taskDocRef.id ;  // auto ID
    return taskDocRef.set(task);

  }
  // delete task
  static Future<void> deleteTask(Task task){
    return getTasksCollection().doc(task.id).delete() ;
  }

}