import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase
{
  Future<Database> setdata() async{
    var dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path,'my_db');
    var database = await openDatabase(path,version: 1,onCreate: mytable);
    return database;
  }
  
  
  Future<void> mytable(Database notesdb,int version)async{
    String sql='CREATE TABLE notes(id integer primary key autoincrement, Note text)';
    await notesdb.execute(sql);
  }
}