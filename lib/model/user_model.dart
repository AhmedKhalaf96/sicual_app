class UserDataModel{
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String image;
  late String bio;
  late String cover;
  UserDataModel({
   required this.name, required this.email, required this.phone, required this.bio,
    required this.cover,required this.image,required this.uid
});
  UserDataModel.fromJson(Map<String,dynamic>json){
     name=json['name'];
     email=json['email'];
     phone=json['phone'];
     uid=json['uid'];
     image=json['image'];
     bio=json['bio'];
     cover=json['cover'];
  }
  Map<String,dynamic>tomap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uid':uid,
      'image':image,
      'bio':bio,
      'cover':cover,


    };
  }
}