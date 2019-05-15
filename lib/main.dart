import 'package:flutter/material.dart';
import 'package:flutter_gank/page/welcome.dart';

import 'model/index.dart';
import 'router.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(gankApp());

Widget gankApp() {
  return ScopedModel<AppModel>(
    model: AppModel(),
    child: GankApp()
  );
}

class GankApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Welcome(),
//      routes: routers,
      onGenerateRoute: createRouter,
      theme: new ThemeData(
        splashColor: AppModel.of(context).theme.splashColor, //水波纹颜色
        primaryColor: AppModel.of(context).theme.primaryColor,
        backgroundColor: AppModel.of(context).theme.backgroundColor,
        primarySwatch: Colors.red,
        accentColor: AppModel.of(context).theme.accentColor,
        textTheme: AppModel.of(context).theme.textTheme,
      ),
    );
  }

}