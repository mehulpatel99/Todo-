import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Database/db_helper.dart';
class repo
{
  MyDatabase? _database;
  Database? _mydatabase;

  repo(){
    _database=MyDatabase();
  }

  Future<Database?> get notesd async{
    if(_mydatabase != null){
      return  _mydatabase;
    }else{
      _mydatabase= await _database?.setdata();
      return _mydatabase;
    }
  }

  inser(table,data)async{
    var con = await notesd;
    return await con!.insert(table,data);
  }
  getData(table)async{
    var con = await notesd;
    return await con!.query(table);
  }
  update(table,data)async{
    var con=await notesd;
    return await con!.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }
  delete(table,data)async{
    var con=await notesd;
    return await con!.delete(table,where: 'id=?',whereArgs: [data['id']]);
  }
}