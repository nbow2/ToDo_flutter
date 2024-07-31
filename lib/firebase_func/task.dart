class Task{
  static const String collectNameData = 'tasks';
  String title ;
  String desc ;
  DateTime dateTime ;
  String  id ;
  bool isDone;

  Task({
    this.id = '' ,
    required this.title ,
    required this.desc ,
    required this.dateTime ,
    this.isDone = false
  });

  Map<String,dynamic>toFireStore(){
  return {
    'id':id,
    'title':title,
    'desc':desc,
    'dateTime':dateTime.millisecondsSinceEpoch,
    'isDone':isDone
  };}

  Task.fromFireStore(Map<String,dynamic> data):this(
    id: data['id'] as String ,
    title: data['title'] as String ,
    desc: data['desc'] as String ,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isDone: data['isDone'] as bool,
  );

}