import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/bean/news.dart';
import 'package:flutter_gank/router.dart';

class NewsItem extends StatefulWidget {
  final News news;
  NewsItem({this.news}): assert(news!=null);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsetsDirectional.only(start: 10, end: 10, top: 5, bottom: 3),
      child: InkWell(
          radius: 30,
          onTap: () {
            Navigator.pushNamed(context, RouterName.detail,
                arguments: {"title": widget.news.desc, "url": widget.news.url, "type": widget.news.type});
          },
          child: buildItem()),
    );
  }

  Widget buildItem(){
    if(widget.news.type=="福利"){
      return buildFuli();
    }else{
      return buildNormal();
    }
  }

  Widget buildNormal(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.news.desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '作者：${widget.news.who}     来源：${widget.news.source}',
                  style:
                  TextStyle(fontSize: 12, color: Color(0xffaaaaaa)),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.news.publishedAt,
                  style:
                  TextStyle(fontSize: 11, color: Color(0xffaaaaaa)),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 4),
                  padding: EdgeInsetsDirectional.only(
                      start: 5, end: 5, top: 2, bottom: 3),
                  decoration: BoxDecoration(
                      color: Color(0xffececea),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    widget.news.type,
                    style:
                    TextStyle(fontSize: 11, color: Color(0xff999999)),
                  ),
                )
              ],
            ),
          ),
        ),
        buildImage(widget.news),
      ],
    );
  }

  Widget buildFuli(){
    return Container(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Container(
            height: 160,
            color: Color(0xffe1e1e1),
            child: CachedNetworkImage(
              imageUrl: widget.news.url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 3, bottom: 3),
              color: Color(0x66333333),
              child: Text("时间：${widget.news.publishedAt}", style: TextStyle(fontSize: 12, color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage(News news) {
    if (news.images == null || news.images.isEmpty) return SizedBox();
    return Stack(
      children: <Widget>[
        Container(
          width: 120,
          height: 150,
          color: Color(0xffe1e1e1),
          child: CachedNetworkImage(
            imageUrl: news.images[0],
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            margin: EdgeInsetsDirectional.only(end: 6, bottom: 6),
            padding:
            EdgeInsetsDirectional.only(start: 5, end: 5, top: 1, bottom: 1),
            decoration: BoxDecoration(
                color: Color(0x66000000),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text(
              '${news.images.length}张',
              style: TextStyle(fontSize: 11, color: Color(0xffeeeeee)),
            ),
          ),
        )
      ],
    );
  }
}
