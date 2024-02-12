import 'package:flutter/material.dart';

class Models{
  int? id;
  String? Note;
 

  Usermap(){
    var mapping = Map<String,dynamic>();
    mapping['id']=id??null;
    mapping['Note']=Note;
   

    return mapping;
  }
}