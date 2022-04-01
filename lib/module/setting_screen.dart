import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/module/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,index){},
      builder: (context ,index){
        var model=SocialCubit.get(context).userDataModel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          width: double.maxFinite,
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${model!.cover}")
                              )
                          ),
                        ),
                        alignment: Alignment.topCenter,

                      ),
                      CircleAvatar(
                        radius: 63,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                Text("${model.name}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                Text("${model.bio}",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16,fontWeight: FontWeight.w500)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("100",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                              Text("posts",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 17,fontWeight: FontWeight.w700)),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("120",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                              Text("Photos",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 17,fontWeight: FontWeight.w700)),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("1k",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                              Text("Followers",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 17,fontWeight: FontWeight.w700)),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("98",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                              Text("Following",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 17,fontWeight: FontWeight.w700)),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: OutlinedButton(onPressed: (){}, child: Text("Add Photos",style: TextStyle(letterSpacing: 2),))),
                      SizedBox(width: 5,),
                      OutlinedButton(onPressed:(){
                        SocialCubit.get(context).Profilecover=null;
                        SocialCubit.get(context).ProfileImage=null;

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  EditProfileScreen())
                        );
                      }, child: Icon(Icons.edit))
                    ],
                  ),
                )
              ],
            ),
          ),

        );
      },
    );
  }
}
