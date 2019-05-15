import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'theme.dart';

/// 全局应用数据管理
class AppModel extends Model {
  AppTheme theme = OrangeTheme();

  void switchTheme(AppTheme theme) {
    this.theme = theme;
    notifyListeners();
  }

  static AppModel of(BuildContext context) =>
      ScopedModel.of<AppModel>(context, rebuildOnChange: true);
}
