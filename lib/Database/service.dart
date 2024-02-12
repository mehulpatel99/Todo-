import 'package:flutter/material.dart';
import 'package:todo/Database/model.dart';
import 'package:todo/Database/repository.dart';

class UserService{
  late repo _repository;

  UserService(){
    _repository=repo();
  }

  savedata(Models? _models)async{
    return await _repository.inser('notes', _models!.Usermap());
  }
  readData()async{
    return await _repository.getData('notes');
  }
  updateData(Models? _models)async{
    return await _repository.update('notes', _models!.Usermap());
  }
  deleteData(Models? _models)async{
    return await _repository.delete('notes', _models!.Usermap());
  }
}