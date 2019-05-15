import 'package:flutter/material.dart';
import 'package:flutter_gank/api.dart';
import 'package:flutter_gank/bean/news.dart';
import 'package:flutter_gank/component/news_item.dart';
import 'package:flutter_gank/component/refresh_list.dart';

/// 列表页
class ListPage extends StatefulWidget {
  final String cate;

  ListPage({this.cate}) : assert(cate != null);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ListPage> with AutomaticKeepAliveClientMixin {
  List<News> list = <News>[];
  bool hasData = true;
  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  Future refreshData() async {
    page = 1;
    List<News> data = await GankApi.getCateData(widget.cate, page);
    if (data != null) {
      setState(() {
        list.clear();
        list.addAll(data);
      });
    }
    return Future.value();
  }

  Future loadMoreData() async {
    page++;
    List<News> data = await GankApi.getCateData(widget.cate, page);
    if (data != null) {
      setState(() {
        list.addAll(data);
      });
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshList(
        itemCount: list.length,
        onRefresh: refreshData,
        loadMore: loadMoreData,
        hasMoreData: hasData,
        autoRefresh: true,
        itemBuilder: (context,index) => NewsItem(news: list[index],));
  }

  @override
  bool get wantKeepAlive => true;
}
