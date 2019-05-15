
import 'package:flutter/material.dart';

abstract class AppTheme{
  Color primaryColor;
  Color backgroundColor;
  Color accentColor;
  Color splashColor;
  TextTheme textTheme;
}

class OrangeTheme extends AppTheme{
  @override
  Color get primaryColor => Colors.deepOrange;
  @override
  Color get backgroundColor => Colors.white;
  @override
  Color get accentColor => Colors.deepOrangeAccent;
  @override
  Color get splashColor => Color.fromARGB(40, 250, 250, 250);//水波纹颜色
  @override
  TextTheme get textTheme => TextTheme(
    body1: TextStyle(color: Color(0xFF333333), fontSize: 16)
  );
}