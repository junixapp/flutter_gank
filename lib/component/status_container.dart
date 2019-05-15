import 'package:flutter/material.dart';

enum Status { Loading, Error, Empty, Content }

/// 状态切换布局
class StatusContainer extends StatefulWidget {
  final Status status;
  final Widget loadingWidget, errorWidget, emptyWidget, contentWidget;

  StatusContainer(
      {this.status = Status.Loading,
      this.loadingWidget,
      this.errorWidget,
      this.emptyWidget,
      this.contentWidget})
      : assert(contentWidget != null);

  @override
  StatusContainerState createState() => StatusContainerState();
}

class StatusContainerState extends State<StatusContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildChild(),
    );
  }

  Widget buildChild() {
    switch (widget.status) {
      case Status.Loading:
        return buildLoading();
      case Status.Error:
        return buildError();
      case Status.Empty:
        return buildEmpty();
      case Status.Content:
        return widget.contentWidget;
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  Widget buildLoading() {
    return widget.loadingWidget != null
        ? widget.loadingWidget
        : CircularProgressIndicator();
  }

  Widget buildError() {
    return widget.errorWidget != null ? widget.errorWidget : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error,
          size: 50,
          color: Color(0XFF999999),
        ),
        SizedBox(height: 4,),
        Text("加载失败", style: TextStyle(color: Color(0XFF888888), fontSize: 16),)
      ],
    );
  }

  Widget buildEmpty() {
    return widget.emptyWidget != null
        ? widget.emptyWidget
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.not_interested,
                size: 50,
                color: Color(0XFF999999),
              ),
              SizedBox(height: 4,),
              Text("没有数据", style: TextStyle(color: Color(0XFF888888), fontSize: 16),)
            ],
          );
  }
}
