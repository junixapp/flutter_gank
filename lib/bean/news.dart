class News {
  String _id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  String who;
  bool used;
  List<String> images;

  static News fromMap(Map<String, dynamic> map) {
    News news = new News();
    news._id = map['_id'];
    news.createdAt = map['createdAt'];
    news.desc = map['desc'];
    news.publishedAt = map['publishedAt'];
    news.source = map['source'];
    news.type = map['type'];
    news.url = map['url'];
    news.who = map['who'];
    news.used = map['used'];

    List<dynamic> dynamicList0 = map['images'] ?? [];
    news.images = new List();
    news.images.addAll(dynamicList0.map((o) => o.toString()));

    return news;
  }

  static List<News> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<News> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
