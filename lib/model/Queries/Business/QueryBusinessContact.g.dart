// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QueryBusinessContact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryBusinessContact _$QueryBusinessContactFromJson(
        Map<String, dynamic> json) =>
    QueryBusinessContact()
      ..nautcli_empresa = json['nautcli_empresa'] as String
      ..nautcli = json['nautcli'] as String
      ..tipo_identificacion = json['tipo_identificacion'] as int
      ..persona_contacto = json['persona_contacto'] as String
      ..datper = json['datper'] as String
      ..cargo_contacto = json['cargo_contacto'] as String
      ..celular_contacto = json['celular_contacto'] as String
      ..email_contacto = json['email_contacto'] as String;

Map<String, dynamic> _$QueryBusinessContactToJson(
        QueryBusinessContact instance) =>
    <String, dynamic>{
      'nautcli_empresa': instance.nautcli_empresa,
      'nautcli': instance.nautcli,
      'tipo_identificacion': instance.tipo_identificacion,
      'persona_contacto': instance.persona_contacto,
      'datper': instance.datper,
      'cargo_contacto': instance.cargo_contacto,
      'celular_contacto': instance.celular_contacto,
      'email_contacto': instance.email_contacto,
    };
