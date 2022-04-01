
import 'package:chatty/model/user_model.dart';
import 'package:chatty/module/chat_details_screen.dart';
import 'package:flutter/material.dart';

Widget TextFormFieldCustom({
  required TextEditingController controller,
  var validator,
  required String lable,
  var prifixicon,
  var suffixicon,
  var suffixpress,
  var priffixpress,
  var ontap,
  var type,
  bool obscure=false,
})=>TextFormField(
  controller:controller,
  validator: validator,
  keyboardType:type ,
  onTap: ontap,
  obscureText: obscure,
  decoration: InputDecoration(
      labelText: lable,labelStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
      prefix: prifixicon !=null ?IconButton(onPressed:priffixpress, icon: Icon(prifixicon)):null,
      suffix: suffixicon !=null ?IconButton(onPressed:suffixpress, icon: Icon(suffixicon)):null,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1,color: Colors.blue)
      )
  ),
);

Widget defultButton({
  required var function,
  required var lable,
})=>InkWell(
  onTap:function,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5)
    ),
    height: 50,child: Center(child: Text('${lable}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)),
  ),
);

Widget itemchat(UserDataModel model,context)=>InkWell(
  onTap: (){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ChatDetailsScreen(userDataModel: model))
    );
  },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Container(

      padding:EdgeInsets.only(right: 10.0),

      decoration: BoxDecoration(

        color: Colors.grey[200],

        borderRadius: BorderRadius.circular(35),

      ),

      child: Row(

        children: [

          CircleAvatar(

            backgroundImage: NetworkImage('${model.image}'),

            radius: 35,

          ),

          SizedBox(width: 15,),

          Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text('${model.name}',style: TextStyle(

                  color: Colors.black,fontSize: 19,

                  fontWeight: FontWeight.bold

              ),),

              Text(' Hi Ahmed ',style: TextStyle(

                  color: Colors.blue[800],fontSize: 15,

                  fontWeight: FontWeight.w600

              ),),



            ],

          ),

          Spacer(),

          Padding(

            padding: const EdgeInsets.only(right: 25),

            child: Column(

              children: [

                CircleAvatar(

                  radius: 12,

                  backgroundColor: Colors.blue[900],

                  child: Text(' 1 ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                ),

                SizedBox(height: 10,),

                Text('8.22',style: TextStyle(color: Colors.grey[800]),)

              ],

            ),

          )

        ],

      ),

    ),

  ),
);

