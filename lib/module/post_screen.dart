import 'package:chatty/layoute/chat_layoute.dart';
import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
   PostScreen({Key? key}) : super(key: key);
   var postcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var postimage=SocialCubit.get(context).PostImage;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,elevation: 0.0,
            title: Text('Add Post',style: TextStyle(fontSize: 22,color: Colors.black,),),
            leading: InkWell(onTap:(){
              Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) =>  SocialLayoutScreen())
              );
            },child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
            actions: [
              TextButton(
                child: Text('Post',style: TextStyle(
                    fontSize: 21,fontWeight: FontWeight.bold
                ),),
                onPressed: (){
                  if(SocialCubit.get(context).PostImage==null){
                    SocialCubit.get(context).CreatePost(text: postcontroller.text, datetime: DateTime.now().toString());
                  }else{
                    SocialCubit.get(context).UploadPostImage(text: postcontroller.text, datetime: DateTime.now().toString());
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  SocialLayoutScreen())
                  );
                },
              ),
              SizedBox(width: 10,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadDateState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${SocialCubit.get(context).userDataModel?.image}'),
                      radius: 30,
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${SocialCubit.get(context).userDataModel?.name}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,height: 1.5)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: postcontroller,
                  decoration: InputDecoration(
                    hintText: 'whats in your mind ...',
                    border: InputBorder.none,
                  )
                  ),
                ),
                if(SocialCubit.get(context).PostImage!=null)
                  Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:FileImage(postimage!),
                                )
                            ),
                          ),
                          IconButton(onPressed: (){
                            SocialCubit.get(context).RemovePostImage();
                          }, icon: CircleAvatar(
                              radius: 20,backgroundColor: Colors.blue[600],
                              child: Icon(Icons.close,)),)
                        ],
                      ),
                      alignment: Alignment.topCenter,

                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 25,),
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostimage();
                      }, child: Row(
                        children: [
                          Icon(Icons.camera_enhance_outlined),
                          SizedBox(width: 5,),
                          Text('Add photo'),
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child:Text('Tags'),
                        ),
                    ),

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
