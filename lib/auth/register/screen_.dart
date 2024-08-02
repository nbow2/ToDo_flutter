import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/auth/text_input_field.dart';
import 'package:todo_demo/firebase_func/dialog_utils.dart';
import 'package:todo_demo/home/homescreen.dart';
import 'package:todo_demo/provider/config_provider.dart';
import '../../my_theme/app_colors.dart';

class Screen_Register extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<Screen_Register> createState() => _Screen_RegisterState();
}

class _Screen_RegisterState extends State<Screen_Register> {
  TextEditingController name = TextEditingController(text: 'ahmed');

  TextEditingController email = TextEditingController(text: 'ahmed@ahmed.com');

  TextEditingController password = TextEditingController(text: '123456');

  TextEditingController confirmPassword = TextEditingController(text: '123456');

  var formKEY =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width ;
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<ConfigProvider>(context);
    return Stack(
      children: [
        Container(
          color: provider.IsLightMode() ?  AppColors.backgroundLightColor : AppColors.backgroundDarkColor,
          child: Image.asset('assets/images/background.png' ,
            width: double.infinity,height: double.infinity, fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Create Account'),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
          ),
          body: Form(
            key: formKEY,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height *0.25,),
                  TextInputField(
                    label: 'User Name',
                    valid: (text){
                      if(text == null || text.trim().isEmpty)
                        {
                          return 'PLease enter name';
                        }
                      return null ;
                    },
                    controller: name,
                  ),
                  TextInputField(
                    label: 'Email',
                    keyboard: TextInputType.emailAddress,
                    valid: (text){
                      if(text == null || text.trim().isEmpty)
                      {
                        return 'PLease enter Email';
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return 'Please enter valid Email';
                      }
                      return null ;
                    },
                    controller: email,
                  ),
                  TextInputField(label: 'password',
                    valid: (text){
                      if(text == null || text.trim().isEmpty)
                      {
                        return 'PLease enter Password';
                      }
                      if(text.length < 6) return 'Please enter password  must be 6 chars or more';
                      return null ;
                    },
                    keyboard: TextInputType.text,
                    controller: password,
                    ScureText: true,

                  ),
                  TextInputField(label: 'Confirm Password',
                    valid: (text){
                      if(text == null || text.trim().isEmpty)
                      {
                        return 'PLease enter Confirm Password';
                      }
                      if(text != password.text){
                        return "Confirm password doesn't math Password" ;
                      }
                      return null ;
                    },
                    controller: confirmPassword,
                    keyboard: TextInputType.text,
                    ScureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)
                      ) ,
                        onPressed: (){
                        SignUp();
                        },
                        child: Text(
                          'Sign UP' ,
                          style: TextStyle(
                              color: AppColors.white
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void SignUp() async{
    if(formKEY.currentState?.validate() == true){
      //todo show loading circle
      DialogUtils.showLoading(context: context, massage: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        //todo:// hide loading
        DialogUtils.hideloading(context);
        //todo // show massage
        DialogUtils.showMassage(
            context: context,
            massage: "Register Successfully",
            title: 'Success',
            posActionName: 'Ok',
            posAction: (){
              Navigator.of(context).pushNamed(Homescreen.routeName);
        });
        print(credential.user?.uid?? "user is not Existing");

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo:// hide loading
          DialogUtils.hideloading(context);
          //todo // show massage
          DialogUtils.showMassage(
              context: context,
              massage: "The password provided is too weak." ,
              title: 'Error',
              posActionName: 'Ok',
              posAction: (){
                Navigator.pop(context);
              });
          print('The password provided is too weak.');

        } else if (e.code == 'email-already-in-use') {
          //todo:// hide loading
          DialogUtils.hideloading(context);
          //todo // show massage
          DialogUtils.showMassage(
              context: context,
              massage: "The account already exists for that email." ,
              title: 'Error',
              posActionName: 'Ok',
              posAction: (){
                Navigator.pop(context);
              });
          print('The account already exists for that email.');

        }  else if (e.code == 'network-request-failed') {
          //todo:// hide loading
          DialogUtils.hideloading(context);
          //todo // show massage
          DialogUtils.showMassage(
              context: context,
              massage: " A network error (such as timeout, interrupted connection or unreachable host) has occurred." ,
              title: 'Error',
              posActionName: 'Ok',
              posAction: (){
                Navigator.pop(context);
              });
          print('The account already exists for that email.');

        }
      } catch (e) {
        DialogUtils.hideloading(context);
        //todo // show massage
        DialogUtils.showMassage(
            context: context,
            massage: e.toString() ,
            title: 'Error',
            posActionName: 'Ok',
            );
        print(e);
      }

    }
  }
}
