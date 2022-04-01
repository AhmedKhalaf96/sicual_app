import 'dart:io';
import 'package:chatty/layoute/cubit/social_state.dart';
import 'package:chatty/model/message_model.dart';
import 'package:chatty/model/post_model.dart';
import 'package:chatty/model/user_model.dart';
import 'package:chatty/module/chat_screen.dart';
import 'package:chatty/module/home_screen.dart';
import 'package:chatty/module/setting_screen.dart';
import 'package:chatty/module/user_screen.dart';
import 'package:chatty/shared/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserDataModel? userDataModel;
  int currentIndex = 0;
  List<Widget>screens = [
    HomeScreen(),
    ChatScreen(),
    SettingScreen()
  ];
  List<String>titles = [
    'Home',
    'Chats',
    'Setting'
  ];
  void Scr(var ind){
    currentIndex = ind;
    emit(SocialApptChangeState());
  }

  void getUserData(){
    emit(GetUserLoadDataState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      userDataModel=UserDataModel.fromJson(value.data()!);
      //emit(GetUserLoadDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetUserLoadDataErrorState());

    });
  }

  File? ProfileImage;
  var picker=ImagePicker();
  Future getprofileimage()async{
    final pickedfile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedfile !=null){
      ProfileImage=File(pickedfile.path);
      emit(ProfileImageSuccessState());
    }else{
      print("No image selected");
      emit(ProfileImageErrorState());

    }
  }

  File? Profilecover;
  var coverpicker=ImagePicker();
  Future getcoverimage()async{
    final pickedfile=await coverpicker.pickImage(source: ImageSource.gallery);
    if(pickedfile !=null){
      Profilecover=File(pickedfile.path);
      emit(coverImageSuccessState());
    }else{
      print("No image selected");
      emit(coverImageErrorState());

    }
  }

  void UploadProfileImage({
    required String name,
    required String phone,
    required String bio,}){
    emit(UpdateUserLoadDateState());
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    Future<Null> ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!).then((p0){
      p0.ref.getDownloadURL().then((value) {
        print("value prof ${value}");
        updateuserdata(name: name, phone: phone, bio: bio,image:value );
        emit(UpdateProfileImageSuccessState());
      }).catchError((error){
        emit(UpdateProfileImageErrorState());
      });
    }).catchError((error){
      emit(UpdateProfileImageErrorState());
    });
  }

  String ImageCoverURL='';
  void UploadCoverImage({
    required String name,
    required String phone,
    required String bio,}){
    emit(UpdateUserLoadDateState());
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    Future<Null> ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(Profilecover!.path).pathSegments.last}')
        .putFile(Profilecover!).then((p0){
      p0.ref.getDownloadURL().then((value) {
        print("value cover ${value}");
        updateuserdata(name: name, phone: phone, bio: bio,cover:value );
        print(ImageCoverURL);
        emit(UpdatecoverImageSuccessState());
      }).catchError((error){
        emit(UpdatecoverImageErrorState());
      });
    }).catchError((error){
      emit(UpdatecoverImageErrorState());
    });
  }


  void updateuserdata({
    required String name,
    required String phone,
    required String bio,
    String email='',
    String uid='',
    String? image,
    String? cover,
  }){
    emit(UpdateUserLoadDateState());
    UserDataModel model=UserDataModel(
      name:name,
      email:userDataModel!.email,
      phone:phone,
      uid:userDataModel!.uid,
      image:image??userDataModel!.image,
      bio:bio,
      cover:cover??userDataModel!.cover,
    );
    FirebaseFirestore.instance.collection('users').doc(userDataModel!.uid).update(model.tomap()).then((value){
      getUserData();
      emit(UpdateUserSuccessState());
    }).catchError((error){
      emit(UpdateUserErrorState());

    });
  }


  File? PostImage;
  var Postpicker=ImagePicker();
  Future getPostimage()async{
    final pickedfile=await Postpicker.pickImage(source: ImageSource.gallery);
    if(pickedfile !=null){
      PostImage=File(pickedfile.path);
      emit(PostImageSuccessState());
    }else{
      print("No image selected");
      emit(PostImageErrorState());

    }
  }

  void RemovePostImage(){
    PostImage=null;
    emit(RemovePostImageState());
  }

  void UploadPostImage({
    required String text,
    required String datetime,
  }){
    emit(CreatePostLoadDateState());
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    Future<Null> ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!).then((p0){
      p0.ref.getDownloadURL().then((value) {
        CreatePost(text: text, datetime: datetime,postImage: value);
        emit(CreatePostSuccessState());
      }).catchError((error){
        emit(CreatePostErrorState());
      });
    }).catchError((error){
      emit(UpdatecoverImageErrorState());
    });
  }

  void CreatePost({
    required String text,
    required String datetime,
    String? postImage,
  }){

    emit(UpdateUserLoadDateState());
    PostModel model=PostModel(
      name:userDataModel!.name,
      uid:userDataModel!.uid,
      image:userDataModel!.image,
      datetime:datetime,
      text:text,
      postImage:postImage??'',
    );
    FirebaseFirestore.instance.collection('posts').add(model.tomap()).then((value){
      getPost();
      emit(CreatePostSuccessState());
    }).catchError((error){
      emit(CreatePostErrorState());

    });
  }

  List<PostModel> posts=[];
  List<String> postid=[];
  List<int> likes=[];
  void getPost(){
    posts=[];
    likes=[];
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value){
          likes.add(value.docs.length);
          postid.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){

        });
      });
      //emit(GetPostLoadDataSuccessState());

    }).catchError((error){
      emit(GetPostLoadDataErrorState());
    });
  }
  void getlikes(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userDataModel!.uid)
        .set({
      'like':true,
    }).then((value){
          emit(GetLikeSuccessState());
    }).catchError((error){
      emit(GetLikeErrorState());
    });
  }

  List<UserDataModel> users=[];
  void getUsers()async{
    users=[];
    await FirebaseFirestore.instance
        .collection('users').get().then((value){
      value.docs.forEach((element) {
        if(element.data()['uid']!=uid)
          users.add(UserDataModel.fromJson(element.data()));
      });
      emit(getAllUserSuccessState());
    }).catchError((error){
      emit(getAllUserErrorState());

    });
  }

  void sendMessage({
    required String recieverId,
    required String dateTime,
    required String text,
  }){
    MessageModel messageModel=MessageModel(
        senderId: userDataModel!.uid, recieverId: recieverId, dateTime: dateTime, text: text);
    //to my chat
    FirebaseFirestore.instance.collection('users').doc(userDataModel!.uid).collection('chats').doc(recieverId)
    .collection('messages').add(messageModel.tomap()).then((value){
      emit(SendMessageSuccessState());
     }).catchError((error){
       emit(SendMessageErrorState());
     });
     // to other chat
    FirebaseFirestore.instance.collection('users').doc(recieverId).collection('chats').doc(userDataModel!.uid)
        .collection('messages').add(messageModel.tomap()).then((value){
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
}

  List<MessageModel> messages=[];
  void getMessage({required String recieverID})async{
    FirebaseFirestore.instance.collection('users').doc(uid).collection('chats').doc(recieverID).collection('messages')
        .orderBy('dateTime').snapshots().listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccess());
    });
  }
}