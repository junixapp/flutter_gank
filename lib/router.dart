import 'package:flutter/material.dart';
import 'package:flutter_gank/page/404.dart';
import 'package:flutter_gank/page/detail.dart';
import 'package:flutter_gank/page/home.dart';
import 'package:flutter_gank/page/search.dart';
import 'package:flutter_gank/page/welcome.dart';

/// 路由表

class RouterName {
  static const String welcome = '/';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String search = '/search';
}

/// 动态路由
Route<dynamic> createRouter(RouteSettings setting) {
  switch (setting.name) {
    case RouterName.welcome:
      return SlideRightRoute(widget: Welcome(), settings: setting);
    case RouterName.home:
      return SlideRightRoute(widget: Home(), settings: setting);
    case RouterName.detail:
      return SlideRightRoute(widget: Detail(), settings: setting);
    case RouterName.search:
      return SlideRightRoute(widget: Search(), settings: setting);
  }
  return SlideRightRoute(widget: NotFound(), settings: setting);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings settings;

  SlideRightRoute({this.widget, this.settings})
      : super(
    settings: settings,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

//final routers = {
//  RouterName.welcome: (context) => Welcome(),
//  RouterName.home: (context) => Home(),
//  RouterName.detail: (context) => Detail(),
//};
