import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/auth/register/screen_.dart';
import 'package:todo_demo/auth/text_input_field.dart';
import 'package:todo_demo/provider/config_provider.dart';
import '../../home/homescreen.dart';
import '../../my_theme/app_colors.dart';
import '../../firebase_func/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController(text: 'ahmed@route.com');

  TextEditingController password = TextEditingController(text: '123456');

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
            title: const Text('Login'),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Welcome Back! ' ,style: Theme.of(context).textTheme.titleMedium,),
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
                  Row(
                    children: [
                      TextButton(
                          onPressed: (){
                            //Navigator.of(context).pushNamed(Screen_Register.routeName);
                          },
                          child: Text(
                            'Forget password?' ,
                            style: TextStyle(fontSize:18 ,color: AppColors.gray),
                            textAlign: TextAlign.start,
                          )
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)
                      ) ,
                        onPressed: (){
                        Login();
                        },
                        child: Text(
                          'Login' ,
                          style: TextStyle(
                              color: AppColors.white
                          ),
                        )
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(Screen_Register.routeName);
                      },
                      child: Text(
                        'OR Sign UP' ,
                        style: TextStyle(color: AppColors.primaryColor),
                      )
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void Login() async{
    if(formKEY.currentState?.validate() == true){

      DialogUtils.showLoading(context: context, massage: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text
        );
        DialogUtils.hideloading(context);
        DialogUtils.showMassage(
            context: context,
            massage: 'Login Successfully.' ,
            title: 'Success',posActionName: 'Ok',
            posAction: (){
              Navigator.of(context).pushNamed(Homescreen.routeName);
            });
        print(credential.user?.uid ?? "user is not Existing");

      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideloading(context);
          DialogUtils.showMassage(
              context: context,
              massage: 'The supplied auth credential is incorrect, malformed or has expired.' ,
              title: 'Error',
              posActionName: 'Ok',
              );
          print('The supplied auth credential is incorrect, malformed or has expired.');
        }
        else if (e.code == 'network-request-failed') {
          //todo:// hide loading
          DialogUtils.hideloading(context);
          //todo // show massage
          DialogUtils.showMassage(
              context: context,
              massage: " A network error (such as timeout, interrupted connection or unreachable host) has occurred." ,
              title: 'Error',
              posActionName: 'Ok',
              );
          print('The account already exists for that email.');

        }
      }
      catch (e){
        DialogUtils.hideloading(context);
        DialogUtils.showMassage(
            context: context,
            massage: e.toString(),
            title: 'Error',
            posActionName: 'Ok',
            );
        print(e.toString());
      }

    }
  }
}