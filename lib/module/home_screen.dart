import 'package:buildcondition/buildcondition.dart';
import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/model/post_model.dart';
import 'package:chatty/module/post_screen.dart';
import 'package:chatty/shared/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   //var commentcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          builder: (context)=>Scaffold(
            body:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${SocialCubit.get(context).userDataModel?.image}'),
                          radius: 20,
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  PostScreen())
                            );
                          },
                          child: Container(
                            height: 50,width: wid(context)-80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('  What’s in your mind ?',style: TextStyle(color: Colors.grey[800],fontSize: 18),),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 20,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.network('https://img.freepik.com/free-photo/photo-cheerful-delighted-african-american-woman-types-sms-modern-cell-phone-device-enjoys-good-internet-connection_273609-25670.jpg?w=740',
                          fit: BoxFit.cover,height: 200,width: double.maxFinite,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Communicate With New Friends",style: TextStyle(color:Colors.grey[700],fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:(context,index) =>BuildPost(SocialCubit.get(context).posts[index],context,index),
                      separatorBuilder:(context,index) => SizedBox(height: 15),
                      itemCount: SocialCubit.get(context).posts.length)
                ],
              ),
            ),

          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
          condition: true,//SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).userDataModel!=null ,
        );
      },

    );
  }
  Widget BuildPost(PostModel model,context,index)=> Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${model.image}'),
                  radius: 25,
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${model.name}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,height: 1.5)),
                      Text("March 5,2022 at 10.30 am",style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 14,height: 1.5,fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                IconButton(onPressed:(){} , icon: Icon(Icons.more_horiz_outlined,size: 16,),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Divider(height: 1,color: Colors.grey[400],thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('${model.text}',
                style: TextStyle(fontSize: 15,height: 1.4,fontWeight: FontWeight.w600),
              ),
            ),
            if(model.postImage!='')
              Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: double.maxFinite,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("${model.postImage}")
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
              child: Row(
                children: [
                  Icon(Icons.favorite_border,color: Colors.red,),
                  SizedBox(width: 10,),
                  Text("${SocialCubit.get(context).likes[index]}",style: TextStyle(color: Colors.grey[700])),
                  Spacer(),
                  Icon(Icons.mode_comment,color: Colors.grey[600],),
                  SizedBox(width: 10,),
                  Text("450 Comments",style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            Divider(height: 1,color: Colors.grey[400],thickness: 1),
            SizedBox(height: 10,),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${SocialCubit.get(context).userDataModel?.image}'),
                  radius: 20,
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      //controller: commentcontroller,
                      decoration: InputDecoration(
                        hintText: 'write comment here',hintStyle: TextStyle(color: Colors.grey[600]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 1,color: Colors.blue)
                          )
                      ),

                    ),
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                    onTap: (){
                      SocialCubit.get(context).getlikes(SocialCubit.get(context).postid[index]);
                    },
                    child: Icon(Icons.favorite_border,color: Colors.grey[500],)),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 10,),
            // Container(
            //   height: 40,
            //   decoration: BoxDecoration(
            //     color: Colors.blue[600],
            //     borderRadius: BorderRadius.circular(25)
            //   ),
            //   child: Center(child: Text('Add Comment',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)),
            // )

          ],
        ),
      )
  );
}
