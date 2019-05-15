import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final webviewReference = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    webviewReference.onBack.listen((_) {});
    webviewReference.onProgressChanged.listen((progress) {
      print("load progress: $progress");
    });
    webviewReference.onStateChanged.listen((WebViewStateChanged state) {
//      if (state.type == WebViewState.shouldStart) {
//        webviewReference.hide();
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> params = ModalRoute.of(context).settings.arguments;
    return params['type'] == '福利'
        ? buildImageViewer(params['url'])
        : buildWebView(params['title'], params['url']);
  }

  Widget buildWebView(String title, String url) {
    return WebviewScaffold(
      url: url,
      hidden: true,
//      appCacheEnabled: true,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(title),
      ),
    );
  }

  Widget buildImageViewer(String url) {
    return Container(
      color: Colors.black,
      child: PhotoView(
        enableRotation: true,
        imageProvider: CachedNetworkImageProvider(url),
      ),
    );
  }
}
