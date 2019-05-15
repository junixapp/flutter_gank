import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gank/model/index.dart';

typedef OnTextChange = void Function(String text);
typedef OnTextCleared = void Function();

/// 搜索输入框组件
class SearchInput extends StatefulWidget {
  final OnTextChange onTextChange;
  final OnTextCleared onTextCleared;
  final String initText;
  final String hintText;
  final int textChangeDuration; //触发textChange事件的时间，单位是毫秒
  SearchInput(
      {this.onTextChange,
      this.onTextCleared,
      this.initText,
      this.hintText,
      this.textChangeDuration = 0});

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  TextEditingController inputController = TextEditingController();
  String content;
  Timer timer;
  bool hasChange = false;
  @override
  void initState() {
    super.initState();
    inputController = TextEditingController(text: widget.initText);
    inputController.addListener(() {
      setState(() {
        content = inputController.value.text;
        if (widget.onTextCleared != null && !hasChange) {
          widget.onTextChange(content);
          hasChange = true; //消费掉
        }
        if (widget.onTextCleared != null && content.isEmpty)
          widget.onTextCleared();
      });
    });

    if(timer==null && widget.textChangeDuration>0){
      timer = Timer.periodic(Duration(milliseconds: widget.textChangeDuration), (timer){
        hasChange = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              width: 100,
              height: 32,
              padding: EdgeInsetsDirectional.only(start: 12, end: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: TextField(
                controller: inputController,
                autofocus: true,
                cursorColor: AppModel.of(context).theme.primaryColor,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero),
              )),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => inputController.clear(),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(timer!=null)timer.cancel();
  }
}
