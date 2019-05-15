import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef LoadMoreCallback = Future<void> Function();

/// 刷新和加载更多的列表
class RefreshList extends StatefulWidget {
  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool hasMoreData;
  final bool autoRefresh;
  final bool enableRefresh;

  RefreshList(
      {this.onRefresh,
      this.loadMore,
      this.itemBuilder,
      this.itemCount = 0,
      this.hasMoreData = true,
      this.autoRefresh = true,
      this.enableRefresh = true});

  @override
  _RefreshListState createState() => _RefreshListState();
}

class _RefreshListState extends State<RefreshList> {
  ScrollController controller = ScrollController();
  bool isLoadingMore = false;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      var offset =
          controller.position.maxScrollExtent - controller.position.pixels;
      if (offset >= 0 && offset <= 35) {
        if (widget.loadMore != null && !isLoadingMore && widget.hasMoreData) {
          setState(() => isLoadingMore = true);
          widget.loadMore().whenComplete(() {
            setState(() {
              isLoadingMore = false;
            });
          });
        }
      }
    });

    //当widget tree build完毕执行
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.autoRefresh) {
        refreshIndicatorKey.currentState.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.enableRefresh
        ? RefreshIndicator(
            key: refreshIndicatorKey,
            child: buildListView(),
            onRefresh: widget.onRefresh,
          )
        : buildListView();
  }

  Widget buildListView() {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: controller,
        itemCount: widget.itemCount + 1,
        itemBuilder: (context, index) {
          if (widget.itemCount == 0) return null;

          if (index == (widget.itemCount)) {
            return buildLoadMore();
          }

          if (widget.itemBuilder != null) {
            return widget.itemBuilder(context, index);
          }
        });
  }

  Widget buildLoadMore() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
          child: widget.hasMoreData
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "加载中...",
                      style: TextStyle(fontSize: 18, color: Color(0Xff222222)),
                    )
                  ],
                )
              : Text(
                  "暂无更多数据",
                  style: TextStyle(color: Color(0xff999999)),
                )),
    );
  }
}
