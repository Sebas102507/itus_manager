// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItusDocument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItusDocument _$ItusDocumentFromJson(Map<String, dynamic> json) => ItusDocument()
  ..id_document = json['id_document'] as int
  ..description = json['description'] as String
  ..alias = json['alias'] as String;

Map<String, dynamic> _$ItusDocumentToJson(ItusDocument instance) =>
    <String, dynamic>{
      'id_document': instance.id_document,
      'description': instance.description,
      'alias': instance.alias,
    };
