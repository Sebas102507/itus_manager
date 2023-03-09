// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Outbound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outbound _$OutboundFromJson(Map<String, dynamic> json) => Outbound()
  ..fuente = json['fuente'] as String?
  ..medio = json['medio'] as String?
  ..resumen = json['resumen'] as String?
  ..fecha_envio = json['fecha_envio'] == null
      ? null
      : DateTime.parse(json['fecha_envio'] as String)
  ..mensaje = json['mensaje'] as String?
  ..fechain = json['fechain'] == null
      ? null
      : DateTime.parse(json['fechain'] as String);

Map<String, dynamic> _$OutboundToJson(Outbound instance) => <String, dynamic>{
      'fuente': instance.fuente,
      'medio': instance.medio,
      'resumen': instance.resumen,
      'fecha_envio': instance.fecha_envio?.toIso8601String(),
      'mensaje': instance.mensaje,
      'fechain': instance.fechain?.toIso8601String(),
    };
