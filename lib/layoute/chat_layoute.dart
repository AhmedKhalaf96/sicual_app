import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(title: Text(SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex],
              style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,elevation: 0.0,actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.search,color: Colors.black,size: 30),
                    SizedBox(width: 15,),
                    Icon(Icons.notification_important,color: Colors.black,size: 30,)
                  ],
                ),
              ),
            ],),
          body: SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor:Colors.white,
            selectedItemColor: Colors.blue[700],
            type: BottomNavigationBarType.fixed,
            currentIndex: SocialCubit.get(context).currentIndex,
            onTap:(index){
              SocialCubit.get(context).Scr(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,),
                label: "home",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                label: "Setting",
              ),
            ],

          ),

        );
      },
    );
  }
}
