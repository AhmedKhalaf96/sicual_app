import 'package:buildcondition/buildcondition.dart';
import 'package:chatty/layoute/chat_layoute.dart';
import 'package:chatty/module/module_cubit/module_cubit.dart';
import 'package:chatty/module/module_cubit/module_state.dart';
import 'package:chatty/module/signup.dart';
import 'package:chatty/shared/component/cash_helper.dart';
import 'package:chatty/shared/component/component.dart';
import 'package:chatty/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ModulesCubit(),
        child: BlocConsumer<ModulesCubit,ModulesStates>(
            listener: (context,state){
              if(state is UserLoginSuccess)
              {
                CashHelper.saveData(key: 'uid', value: state.uid).then((value){
                  uid=state.uid;
                  Fluttertoast.showToast(msg: 'Login Success',textColor: Colors.white,backgroundColor: Colors.green,fontSize: 20);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  SocialLayoutScreen())
                  );
                });
              }else if(state is UserLoginError){
                Fluttertoast.showToast(msg: 'Login Error',textColor: Colors.white,backgroundColor: Colors.red,fontSize: 20);

              }
            },
            builder: (context,state){
              return Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LOGIN",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                          SizedBox(height: 15,),
                          Text("Login To Communicate Friends Around World",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.grey[600]),),
                          SizedBox(height: 50,),
                          TextFormFieldCustom(
                            lable: "Email Address",
                            controller:ModulesCubit.get(context).EmailController,
                            type: TextInputType.emailAddress,
                            suffixicon: Icons.email,
                          ),
                          SizedBox(height: 25,),
                          TextFormFieldCustom(
                            lable: "Password",
                            controller:ModulesCubit.get(context).PasswordController,
                            type: TextInputType.text,
                            suffixicon: Icons.lock,
                            obscure: true,
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: InkWell(
                              onTap: (){
                                ModulesCubit.get(context).userLogin(email: ModulesCubit.get(context).EmailController.text,
                                    password: ModulesCubit.get(context).PasswordController.text);
                              },
                              child: BuildCondition(
                                builder:(context)=> Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius:BorderRadius.circular(50)
                                  ),
                                  height: 70,
                                  width: 400,

                                  child:Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)) ,

                                ),
                                fallback: (context)=>Center(child: CircularProgressIndicator()),
                                condition: state is ! UserLoginLoad,
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account ? ',style: TextStyle(color: Colors.blueGrey[800],fontSize: 18),),
                              TextButton(onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  RegesterScreen()));
                              },
                                  child: Text(' Register',style: TextStyle(color: Colors.blue,fontSize: 18),))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}