import 'package:chatty/layoute/cubit/social_cubit.dart';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/module/setting_screen.dart';
import 'package:chatty/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);
   var namecontroller=TextEditingController();
   var biocontroller=TextEditingController();
   var phonecontroller=TextEditingController();
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model=SocialCubit.get(context).userDataModel;
         var profileimage=SocialCubit.get(context).ProfileImage;
         var coverimage=SocialCubit.get(context).Profilecover;

         namecontroller.text=model!.name;
         phonecontroller.text=model.phone;
         biocontroller.text=model.bio;


        return Scaffold(
          appBar: AppBar(title: Text('Edit Profile',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,elevation: 0.0,
            leading: InkWell(child: Icon(Icons.arrow_back_ios,color: Colors.black),onTap: (){
              Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) =>  SettingScreen())
              );
            }),
            actions: [
              TextButton(
                child: Text('Update',style: TextStyle(
                    fontSize: 21,fontWeight: FontWeight.bold
                ),),
                onPressed: (){
                  SocialCubit.get(context).updateuserdata(name: namecontroller.text, phone: phonecontroller.text, bio: biocontroller.text);
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is UpdateUserLoadDateState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                Container(
                  height: 220,
                  child: Stack(
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
                                      image:coverimage==null? NetworkImage('${model.cover}'):FileImage(coverimage) as ImageProvider,
                                  )
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialCubit.get(context).getcoverimage();
                            }, icon: CircleAvatar(
                                radius: 20,backgroundColor: Colors.blue[600],
                                child: Icon(Icons.camera_alt_outlined,)),)
                          ],
                        ),
                        alignment: Alignment.topCenter,

                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 63,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:profileimage==null? NetworkImage('${model.image}'):FileImage(profileimage) as ImageProvider,
                            ),
                          ),
                          IconButton(onPressed: (){
                            SocialCubit.get(context).getprofileimage();
                          }, icon: CircleAvatar(
                              radius: 20,backgroundColor: Colors.blue[600],
                              child: Icon(Icons.camera_alt_outlined,)),)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                if(SocialCubit.get(context).ProfileImage!=null||SocialCubit.get(context).Profilecover!=null)
                  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      if(SocialCubit.get(context).ProfileImage!=null)
                        Expanded(
                        child: defultButton(
                          lable: 'Upload Profile',
                          function: (){
                            SocialCubit.get(context).UploadProfileImage(name: namecontroller.text,bio: biocontroller.text,phone: phonecontroller.text);
                          }
                        ),
                      ),
                      SizedBox(width: 10,),
                      if(SocialCubit.get(context).Profilecover!=null)
                        Expanded(
                        child: defultButton(
                            lable: 'Upload Cover',
                            function: (){
                              SocialCubit.get(context).UploadCoverImage(name: namecontroller.text,bio: biocontroller.text,phone: phonecontroller.text);

                            }
                        ),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormFieldCustom(
                            controller:namecontroller ,
                            lable: 'Name',
                            type: TextInputType.name,
                            suffixicon: Icons.perm_contact_cal
                        ),
                        height: 80,
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: TextFormFieldCustom(
                            controller:biocontroller ,
                            lable: 'Bio',
                            type: TextInputType.text,
                            suffixicon: Icons.text_fields
                        ),
                        height: 80,
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: TextFormFieldCustom(
                            controller:phonecontroller ,
                            lable: 'Phone',
                            type: TextInputType.phone,
                            suffixicon: Icons.phone_android
                        ),
                        height: 80,
                      ),
                      SizedBox(height: 20,),
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
