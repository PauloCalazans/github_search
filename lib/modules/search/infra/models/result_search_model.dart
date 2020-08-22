import 'dart:convert';

import 'package:github_search/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String img;
  final String title;
  final String content;

  ResultSearchModel({this.img, this.title, this.content});

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'img': this.img,
      'title': this.title,
      'content': this.content,
    } as Map<String, dynamic>;
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
  if (map == null) return null;

    return ResultSearchModel(
      img: map['img'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel fromJson(String source) => fromMap(json.decode(source));
}