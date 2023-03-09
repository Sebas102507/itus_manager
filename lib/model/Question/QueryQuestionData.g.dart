// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QueryQuestionData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryQuestionData _$QueryQuestionDataFromJson(Map<String, dynamic> json) =>
    QueryQuestionData()
      ..data = (json['data'] as List<dynamic>)
          .map((e) => QueryQuestion.fromJson(e as Map<String, dynamic>))
          .toList()
      ..links =
          QueryQuestionLinks.fromJson(json['links'] as Map<String, dynamic>)
      ..meta =
          QueryQuestionMetadata.fromJson(json['meta'] as Map<String, dynamic>);

Map<String, dynamic> _$QueryQuestionDataToJson(QueryQuestionData instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'links': instance.links.toJson(),
      'meta': instance.meta.toJson(),
    };
