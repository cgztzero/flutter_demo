import 'package:json_annotation/json_annotation.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class PostEntity {
  String? title;
  String? author;
  String? desc;
  String? niceDate;
  String? link;

  PostEntity(this.title, this.author, this.desc, this.niceDate,this.link);

  factory PostEntity.fromJson(Map<String, dynamic> json) => _$PostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostEntityToJson(this);
}