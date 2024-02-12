import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/home.dart';

class mysplash extends StatefulWidget {
  const mysplash({super.key});

  @override
  State<mysplash> createState() => _mysplashState();
}

class _mysplashState extends State<mysplash> {
  myscreen()async{
  await Future.delayed(Duration(seconds: 5));
  // Navigator.pop(context);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>menu()));

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    myscreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
      Lottie.network('https://lottie.host/185816b5-a080-4ab2-a710-0ec6c76cbb1d/rgKTHBLoWn.json')),
    );
  }
}