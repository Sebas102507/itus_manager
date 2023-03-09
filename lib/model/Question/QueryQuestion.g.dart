// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QueryQuestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryQuestion _$QueryQuestionFromJson(Map<String, dynamic> json) =>
    QueryQuestion()
      ..id = json['id'] as int
      ..question = json['question'] as String
      ..answer = json['answer'] as String
      ..campaign = json['campaign'] as String
      ..business = json['business'] as String
      ..validate_optin = json['validate_optin'] as String;

Map<String, dynamic> _$QueryQuestionToJson(QueryQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'campaign': instance.campaign,
      'business': instance.business,
      'validate_optin': instance.validate_optin,
    };
