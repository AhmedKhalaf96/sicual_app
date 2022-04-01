import 'package:chatty/layoute/chat_layoute.dart';
import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/module/login.dart';
import 'package:chatty/shared/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // String? token=await FirebaseMessaging.instance.getToken();
  // print('token is $token');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Fluttertoast.showToast(msg: 'on message',backgroundColor: Colors.green,textColor: Colors.white);
    print(message.data.toString());
        });
  FirebaseMessaging.onMessageOpenedApp.listen((event){
    Fluttertoast.showToast(msg: 'on message open',backgroundColor: Colors.green,textColor: Colors.white);
    print(event.data.toString());
  });
  // Widget widget;
  // if(CashHelper.getData(key: 'uid')==null){
  //   uid='';
  // }else{
  //   CashHelper.getData(key: 'uid');
  // }
  // if(uid!=''){
  //   widget=SocialLayoutScreen();
  // }else{
  //   widget=LoginScreen();
  // }
  BlocOverrides.runZoned(
        () {
      runApp( MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // final Widget startwidget;
  // MyApp(this.startwidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPost()..getUsers())
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LoginScreen(),
          );
    },

      ),
    );
  }
  // Widget build(BuildContext context) {
  //
  //       return MaterialApp(
  //         title: 'Flutter Demo',
  //         debugShowCheckedModeBanner: false,
  //         theme: ThemeData(
  //           primarySwatch: Colors.blue,
  //         ),
  //         home: LoginScreen(),
  //       );
  // }

}
