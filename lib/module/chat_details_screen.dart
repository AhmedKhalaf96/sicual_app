import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/model/message_model.dart';
import 'package:chatty/model/user_model.dart';
import 'package:chatty/module/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserDataModel userDataModel;
  ChatDetailsScreen({required this.userDataModel});
  var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage( recieverID: userDataModel.uid);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                titleSpacing: 0.0,
                elevation: 5.0,
                shadowColor: Colors.grey[200],
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userDataModel.image),
                      radius: 20,
                    ),
                    SizedBox(width: 20,),
                    Text(userDataModel.name,style: TextStyle(color: Colors.black,fontSize: 20),),
                  ],
                ),
                leading: InkWell(
                    onTap: (){
                      Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) =>  ChatScreen())
                      );
                    },
                    child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if(SocialCubit.get(context).userDataModel!.uid==SocialCubit.get(context).messages[index].senderId)
                              return mymessage(SocialCubit.get(context).messages[index]);
                            return recievermessage(SocialCubit.get(context).messages[index]);
                          },
                          separatorBuilder:(context,index)=> SizedBox(height: 10,),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey,width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...'
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              SocialCubit.get(context).sendMessage(recieverId: userDataModel.uid, dateTime: DateTime.now().toString(), text: messageController.text);
                              messageController.text='';
                            },
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(40),
                                ) ,
                                child: Center(child: Icon(Icons.send,color: Colors.blue,size: 35,))),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
  Widget recievermessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(15),
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          )
      ),
      child: Text(model.text,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
    ),
  );
  Widget mymessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(15),
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          )
      ),
      child: Text(model.text,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
    ),
  );

}
