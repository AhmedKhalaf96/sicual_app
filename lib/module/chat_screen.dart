import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40,right: 80,top: 5),
                      ),
                      SizedBox(height: 20,),
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>itemchat(SocialCubit.get(context).users[index],context),
                            separatorBuilder: (context,index)=>Divider(),
                            itemCount: SocialCubit.get(context).users.length),
                      )

                    ],
                  ),
                ),
              ),
            );
          },

        );
  }

}
