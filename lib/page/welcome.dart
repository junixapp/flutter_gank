import 'dart:async';

import 'package:flutter/material.dart';

import '../router.dart';

/// 欢迎界面
class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeState();
  }
}

class _WelcomeState extends State<Welcome> {
  int num = 3;

  @override
  void initState() {
    super.initState();
    _countDown();
  }

  void _countDown() {
    Timer.periodic(Duration(seconds: 1), (timer){
      if (num == 1) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, RouterName.home);
        return;
      }
      setState(() => num -= 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        child: Text(
          "Welcome to Gank!\n$num",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
