// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) => PostEntity(
      json['title'] as String?,
      json['author'] as String?,
      json['desc'] as String?,
      json['niceDate'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$PostEntityToJson(PostEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'desc': instance.desc,
      'niceDate': instance.niceDate,
      'link': instance.link,
    };
