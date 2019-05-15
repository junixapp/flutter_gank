import 'package:flutter/material.dart';
import 'package:flutter_gank/api.dart';
import 'package:flutter_gank/bean/news.dart';
import 'package:flutter_gank/component/news_item.dart';
import 'package:flutter_gank/component/status_container.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<News> list = [];
  Status status = Status.Loading;

  @override
  void initState() {
    super.initState();
    getToday();
  }

  void getToday() async{
    var data = await GankApi.getToday();
    setState(() {
      if(data!=null){
        if(data.isNotEmpty){
          list.addAll(data);
          status = Status.Content;
        }else{
          status = Status.Empty;
        }
      }else{
        status = Status.Error;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatusContainer(
      status: status,
      contentWidget: ListView.builder(
          itemCount: list.length, itemBuilder: (context, index) => NewsItem(news: list[index],)),
    );
  }
}
