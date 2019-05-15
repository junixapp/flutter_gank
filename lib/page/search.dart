import 'package:flutter/material.dart';
import 'package:flutter_gank/api.dart';
import 'package:flutter_gank/bean/news.dart';
import 'package:flutter_gank/component/news_item.dart';
import 'package:flutter_gank/component/refresh_list.dart';
import 'package:flutter_gank/component/search_input.dart';
import 'package:flutter_gank/component/status_container.dart';
import 'package:flutter_gank/const.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Status status = Status.Empty;
  List<News> list = <News>[];
  String cate = "";
  int page = 1;
  Future search(String text, {bool isClear = true}) async {
    List<News> data = await GankApi.search(text, page);
    setState(() {
      if(isClear){
        page = 1;
        list.clear();
      }
      if (data != null) {
        if (data.isNotEmpty) {
          list.addAll(data);
          status = Status.Content;
        } else {
          status = Status.Empty;
        }
      } else {
        status = Status.Error;
      }
    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        titleSpacing: 0,
        title: SearchInput(
          hintText: "我是假的，点击下方按钮进行搜索。。。",
          textChangeDuration: 1000,
          onTextChange: (text) {
            if (text.isEmpty) return;
//            setState(() {
//              status = Status.Loading;
//              search(text);
//            });
          },
          onTextCleared: () => print("cleared"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //all | Android | iOS | 休息视频 | 福利 | 拓展资源 | 前端 | 瞎推荐 | App
          Container(
            padding: EdgeInsetsDirectional.only(start: 8, end: 8, top: 5, bottom: 5),
            color: Color(0xFFeeeeee),
            child: Wrap(
              spacing: 8,
              children: Const.categories.map((s) {
                return ChoiceChip(
                    padding: EdgeInsets.all(0),
                    label: Text(s),
                    selected: false,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          status = Status.Loading;
                          cate = s;
                          search(s);
                        });
                      }
                    });
              }).toList(),
            ),
          ),
          Expanded(
            child: StatusContainer(
              status: status,
              contentWidget: RefreshList(
                autoRefresh: false,
                enableRefresh: false,
                itemCount: list.length,
                loadMore: (){
                  page++;
                  return search(cate, isClear: false);
                },
                itemBuilder: (context, index) => NewsItem(
                      news: list[index],
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
