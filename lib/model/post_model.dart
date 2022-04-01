class PostModel{
  late String name;
  late String uid;
  late String image;
  late String datetime;
  late String text;
  late String postImage;
  PostModel({
   required this.name, required this.image,required this.uid,required this.text,required this.datetime,required this.postImage,
});
  PostModel.fromJson(Map<String,dynamic>json){
     name=json['name'];
     datetime=json['datetime'];
     text=json['text'];
     uid=json['uid'];
     image=json['image'];
     postImage=json['postImage'];
  }
  Map<String,dynamic>tomap(){
    return{
      'name':name,
      'datetime':datetime,
      'text':text,
      'uid':uid,
      'image':image,
      'postImage':postImage,
    };
  }
}