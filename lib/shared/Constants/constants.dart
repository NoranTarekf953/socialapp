// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}

class SizeScreen {


  static double height(context) => MediaQuery.of(context).size.height;
  static double width(context) => MediaQuery.of(context).size.width;

  
}

String dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();

String token='' ;
String uId = '';