import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bean/http_result.dart';
import 'bean/news.dart';

/// api相关
class GankApi {
  static Dio dio;

  static Dio createDio() {
    if (dio != null) return dio;
    dio = new Dio(); // with default Options
    // Set default configs
    dio.options.baseUrl = "http://gank.io/api/";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

    //拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      print("===> dio url: ${options.uri} method: ${options.method}");
      return options; //continue
    }, onResponse: (Response response) {
      // Do something with response data
      print(''''<=== dio statusCode: ${response.statusCode} 
          ${JsonEncoder.withIndent('    ').convert(response.data)}''');
      return response; // continue
    }, onError: (DioError e) {
      // Do something with response error
      print("=== dio error: ${e.error}");
      Fluttertoast.showToast(
          msg: "请求失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return e; //continue
    }));

    return dio;
  }

  /// http://gank.io/api/data/Android/10/1
  static Future<List<News>> getCateData(String cate, int page) async {
    String url = "data/$cate/10/$page";
    try {
      Response response = await createDio().get(url);
      var result = HttpResult.fromMap(response.data);
      if (!result.error) {
        return News.fromMapList(result.results);
      }
    } catch (e) {}
    return null;
  }

  /// search/query/listview/category/Android/count/10/page/1
  static Future<List<News>> search(String cate, int page) async {
    String url = "search/query/listview/category/$cate/count/10/page/$page";
    try {
      Response response = await createDio().get(url);
      var result = HttpResult.fromMap(response.data);
      if (!result.error) {
        return News.fromMapList(result.results);
      }
    } catch (e) {}
    return null;
  }

  /// 获取今天的最新数据
  static Future<List<News>> getToday() async{
    String url = "http://gank.io/api/today";
    try {
      Response response = await createDio().get(url);
      var result = HttpResult.fromMap(response.data);
      if (!result.error) {
        List<News> list = [];
        result.category.forEach((c){
          list.addAll(News.fromMapList(result.results[c]));
        });
        return list;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
