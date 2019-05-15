import 'package:flutter/material.dart';

Future<bool> confirmDialog(BuildContext context,
    {String title,
    String content,
    Function onConfirmClick}) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: Text("取消"),
              ),
              FlatButton(
                onPressed: (){
                  if(onConfirmClick!=null){
                    onConfirmClick();
                  }
                  Navigator.of(context).pop(true);
                },
                child: Text("确定"),
              ),
            ],
          ));
}
