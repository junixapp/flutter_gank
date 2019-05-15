class HttpResult<T> {
  bool error;
  T results;
  List<String> category;

  HttpResult({this.error, this.results});

  static HttpResult fromMap(Map<String, dynamic> map) {
    HttpResult result = new HttpResult();
    result.error = map['error'];
    result.results = map['results'];
    List<dynamic> dynamicList0 = map['category'] ?? [];
    result.category = new List();
    result.category.addAll(dynamicList0.map((o) => o.toString()));
    return result;
  }
}
