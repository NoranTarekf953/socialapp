// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider()=>Padding(
                      padding: const EdgeInsetsDirectional.all(10),
                      child: Container(
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    );
void navigateTo (context,widget)=>Navigator.push(context,
 MaterialPageRoute(builder: (context)=>widget));

 void navigateAndFinish(context,widget) {
   Navigator.pushAndRemoveUntil(
  context,
    MaterialPageRoute(builder: (context)=>widget),
    (route) => false);
 }


 Future<bool?> flutterToast({
  required String msg,
   BuildContext? context,
 required ToastState state ,
 })=> Fluttertoast.showToast
 (msg: msg,
 toastLength: Toast.LENGTH_LONG,
 gravity: ToastGravity.BOTTOM,
 timeInSecForIosWeb: 5,
 backgroundColor: changeToastColor(state),
 textColor: Colors.white,
 fontSize: 16);
 
 /*showToast(
                msg,
                context: context,
                duration: const Duration(seconds: 5),
                borderRadius: BorderRadius.circular(10),
                backgroundColor: changeToastColor(state),
                textStyle: const TextStyle(
                  color: Colors.white
                )
                
                


              );*/


enum ToastState  {success, error,warning}

Color changeToastColor (ToastState state){
  late Color color;
  switch (state) {
    case ToastState.success:
    color = Colors.green;
      break;
      case ToastState.error:
    color = Colors.red;
      break;
      case ToastState.warning:
    color = Colors.amber;
      break;
    
  }
  return color;
}