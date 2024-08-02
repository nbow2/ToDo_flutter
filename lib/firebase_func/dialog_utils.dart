import 'package:flutter/material.dart';
class DialogUtils {
  static void showLoading({required BuildContext context,required String massage}){
    showDialog
      (
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(massage),
                )
              ],
            ),
          );
        }
    );
  }

  static void hideloading(BuildContext context){
    Navigator.pop(context);
  }

  static Future showMassage(
      {
        required BuildContext context ,
        required String massage ,
        String? title,
        String? posActionName,
        Function? posAction,
        String? negActionName,
        Function? negAction,
      })
  { List<Widget> actions = [ ];
    if(posActionName != null){
      actions.add(
          TextButton(
              onPressed: (){
                Navigator.pop(context);
                posAction?.call();
                },
              child: Text(posActionName)
          )
      );
    }
    if(negActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      }, child:Text(negActionName)));
    }
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(massage),
            title: Text(title ?? 'Title not found'),
            actions: actions,
          );
        }
    );
  }
}