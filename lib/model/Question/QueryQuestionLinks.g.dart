// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QueryQuestionLinks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryQuestionLinks _$QueryQuestionLinksFromJson(Map<String, dynamic> json) =>
    QueryQuestionLinks()
      ..first = json['first'] as String
      ..last = json['last'] as String
      ..prev = json['prev'] as String?
      ..next = json['next'] as String?;

Map<String, dynamic> _$QueryQuestionLinksToJson(QueryQuestionLinks instance) =>
    <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };
