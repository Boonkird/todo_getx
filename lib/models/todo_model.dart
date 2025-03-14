import 'dart:convert';


class TodoModel {
  String uid;
  String docId;
  String title;
  String subtitle;
  bool isCompelted;


  TodoModel({
    this.uid = '',
    this.docId = '',
    required this.title,
    this.subtitle = '',
    this.isCompelted = false});


  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'isCompelted': isCompelted,
    'uid': uid,
    'docId':docId,
  };


  TodoModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      subtitle = json['subtitle'],
      isCompelted = json['isCompelted'],
      uid = json['uid'],
      docId = json['docId'];
}
