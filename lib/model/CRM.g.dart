// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CRM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CRM _$CRMFromJson(Map<String, dynamic> json) => CRM()
  ..ciclo_negocio = json['ciclo_negocio'] as String
  ..descripcion_caso = json['descripcion_caso'] as String
  ..resumen = json['resumen'] as String
  ..medio_respuesta = json['medio_respuesta'] as String
  ..fecha_envio = DateTime.parse(json['fecha_envio'] as String)
  ..fecha_cierre = DateTime.parse(json['fecha_cierre'] as String);

Map<String, dynamic> _$CRMToJson(CRM instance) => <String, dynamic>{
      'ciclo_negocio': instance.ciclo_negocio,
      'descripcion_caso': instance.descripcion_caso,
      'resumen': instance.resumen,
      'medio_respuesta': instance.medio_respuesta,
      'fecha_envio': instance.fecha_envio.toIso8601String(),
      'fecha_cierre': instance.fecha_cierre.toIso8601String(),
    };
