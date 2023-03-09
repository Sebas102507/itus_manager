// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QueryUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryUser _$QueryUserFromJson(Map<String, dynamic> json) => QueryUser()
  ..id = json['id'] as int
  ..document = json['document'] as String
  ..txt_tipodoc = json['txt_tipodoc'] as String
  ..tipo_identificacion = json['tipo_identificacion'] as String
  ..name = json['name'] as String
  ..lastname = json['lastname'] as String
  ..cellphone = json['cellphone'] as String
  ..email = json['email'] as String
  ..allow_sms = json['allow_sms'] as int
  ..allow_email = json['allow_email'] as int;

Map<String, dynamic> _$QueryUserToJson(QueryUser instance) => <String, dynamic>{
      'id': instance.id,
      'document': instance.document,
      'txt_tipodoc': instance.txt_tipodoc,
      'tipo_identificacion': instance.tipo_identificacion,
      'name': instance.name,
      'lastname': instance.lastname,
      'cellphone': instance.cellphone,
      'email': instance.email,
      'allow_sms': instance.allow_sms,
      'allow_email': instance.allow_email,
    };
