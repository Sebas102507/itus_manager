// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Inboud.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inbound _$InboundFromJson(Map<String, dynamic> json) => Inbound()
  ..linea = json['linea'] as String
  ..medio = json['medio'] as String
  ..fecha_envio = DateTime.parse(json['fecha_envio'] as String)
  ..resumen = json['resumen'] as String;

Map<String, dynamic> _$InboundToJson(Inbound instance) => <String, dynamic>{
      'linea': instance.linea,
      'medio': instance.medio,
      'fecha_envio': instance.fecha_envio.toIso8601String(),
      'resumen': instance.resumen,
    };
