import 'package:flutter/material.dart';
import 'package:flutter_gank/page/category.dart';
import 'package:flutter_gank/page/today.dart';
import 'package:flutter_gank/router.dart';
import 'package:flutter_gank/util/dialog.dart';

/// 主页面

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //WillPopScope可以拦截返回按键
    return WillPopScope(
        onWillPop: () {
          return confirmDialog(context, title: "提示", content: "客官，您当真要退出？");
        },
        child: Scaffold(
          backgroundColor: Color(0XFFEFEFEF),
          appBar: AppBar(
            title: Text("干货集中营"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10),
                child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () =>
                        Navigator.pushNamed(context, RouterName.search)),
              ),
            ],
          ),
          drawer: createDrawer(),
          body: TabBarView(
            controller: tabController,
            children: <Widget>[Today(), Category()],
          ),
          bottomNavigationBar: Container(
            height: 64,
            decoration: BoxDecoration(
                color: Colors.white,
                border: BorderDirectional(
                    top: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ))),
            child: createTabBar(context),
          ),
        ));
  }

  Widget createTabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.transparent,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Color(0xff999999),
      tabs: <Widget>[
        Tab(
          text: "今日",
          icon: Icon(Icons.today),
        ),
        Tab(text: "分类", icon: Icon(Icons.category)),
      ],
      controller: tabController,
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[],
      ),
    );
  }
}
