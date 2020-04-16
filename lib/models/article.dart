import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

////////==================///////
class Article {
  final String title;
  final String body;
  final String imgUrl;
  final int likes;
  final String html;

  final DocumentReference reference;

  Article.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['body'] != null),
        assert(map['img_url'] != null),
        assert(map['like_count'] != null),

        title = map['title'],
        body = map['body'],
        imgUrl = map['img_url'],
        likes = map['like_count'],
        html = map['html'];

  Article.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Article<$title:$likes>";
}