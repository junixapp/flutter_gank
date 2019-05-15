import 'package:flutter/material.dart';
import 'package:flutter_gank/const.dart';
import 'package:flutter_gank/page/list.dart';
import 'package:flutter_gank/router.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        new TabController(length: Const.categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFFEFEFEF),
      child: Column(
        children: <Widget>[
          createTabBar(context),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: Const.categories
                  .map((s) => ListPage(
                        cate: s,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget createTabBar(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: TabBar(
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelPadding:
            EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 10, top: 10),
        labelStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        unselectedLabelColor: Color.fromARGB(160, 250, 250, 250),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
        tabs: Const.categories.map((s) => Text(s)).toList(),
        controller: tabController,
      ),
    );
  }
}
