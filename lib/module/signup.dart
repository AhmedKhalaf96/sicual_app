import 'package:chatty/layoute/chat_layoute.dart';
import 'package:chatty/module/module_cubit/module_cubit.dart';
import 'package:chatty/module/module_cubit/module_state.dart';
import 'package:chatty/shared/component/cash_helper.dart';
import 'package:chatty/shared/component/component.dart';
import 'package:chatty/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegesterScreen extends StatelessWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ModulesCubit(),
        child: BlocConsumer<ModulesCubit,ModulesStates>(
            listener: (context,state){
              if(state is UserCreatedSuccess){
                CashHelper.saveData(key: 'uid', value: state.uid).then((value){
                  uid=state.uid;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  SocialLayoutScreen())
                  );
                });
              }
            },
            builder: (context,state){
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80,left: 20,right: 20,bottom: 10),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create New Account",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueGrey[800]),),
                            SizedBox(height: 50,),
                            TextFormFieldCustom(
                              lable: 'Name',
                              controller:ModulesCubit.get(context).RNameController,
                              suffixicon: Icons.text_fields_outlined,
                              type: TextInputType.text,

                            ),
                            SizedBox(height: 25,),
                            TextFormFieldCustom(
                              lable: 'Email',
                              controller:ModulesCubit.get(context).REmailController,
                              suffixicon: Icons.email,
                              type: TextInputType.emailAddress,

                            ),
                            SizedBox(height: 25,),
                            TextFormFieldCustom(
                              lable: 'Password',
                              controller:ModulesCubit.get(context).RPasswordController,
                              suffixicon: Icons.lock,
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 25,),
                            TextFormFieldCustom(
                              lable: 'Phone',
                              controller:ModulesCubit.get(context).RPhoneController,
                              suffixicon: Icons.phone,
                              type: TextInputType.number,

                            ),
                            SizedBox(height: 30,),
                            InkWell(
                              onTap: (){
                                ModulesCubit.get(context).userRigester(name:ModulesCubit.get(context).RNameController.text ,
                                  email: ModulesCubit.get(context).REmailController.text,
                                  password: ModulesCubit.get(context).RPasswordController.text,
                                  phone: ModulesCubit.get(context).RPhoneController.text,
                                );
                              },
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius:BorderRadius.circular(50)
                                  ),
                                  height: 70,
                                  width: 200,
                                  child: Center(child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ),
                          ],
                        ),
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