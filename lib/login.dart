import 'package:flutter/material.dart';
import 'package:my_sunday_sqf/Sqf_Database/UI_Sqf/get_SqfData.dart';
import 'package:my_sunday_sqf/Sqf_Database/myModel.dart';
import 'package:my_sunday_sqf/Sqf_Database/service.dart';

import 'add_data.dart';

class LoginSqf extends StatefulWidget {
  const LoginSqf({super.key});

  @override
  State<LoginSqf> createState() => _LoginSqfState();
}

class _LoginSqfState extends State<LoginSqf> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Enter your Email'),
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(hintText: 'Enter your Password'),
            ),
            ElevatedButton(
                onPressed: () {
                  loginmeth();
                  },
                child: Text('SingIn'))
          ],
        ),
      ),
    );
  }
  loginmeth() async {
    var service = MyService();
    var model = MyModel();
    model.email = emailController.text;
    model.pass = passController.text;
    var result = await service.login(email: model.email, pass: model.pass);
    if (result.length==0) {
      print('Invalid');
    } else {
      print('Successfully Login');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GetSqfData(),
          ));
    }
  }
}
