import 'package:flutter/widgets.dart';
import '../../wflib/wfutils/wfhttp_util.dart';

class Photos {
  static const String URL = "https://jsonplaceholder.typicode.com/photos/";

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photos(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      json['albumId'],
      json['id'],
      json['title'],
      json['url'],
      json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
      };

  @override
  String toString() => 'ListData<$albumId:$id>';

  static Future<List<Photos>> loadListData(BuildContext context) async {
    return await WFHttpUtil.get(Photos.URL, context: context).then((response) {
      final Iterable list = response;
      return list.map((model) => Photos.fromJson(model)).toList();
    });
  }
}
