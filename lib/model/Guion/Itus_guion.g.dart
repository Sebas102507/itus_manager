// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Itus_guion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItusGuion _$ItusGuionFromJson(Map<String, dynamic> json) => ItusGuion()
  ..skill = json['skill'] as String
  ..valor_cliente = json['valor_cliente'] as String
  ..guion = json['guion'] as String
  ..tipo_Persona = json['tipo_Persona'] as String
  ..fecha_proceso = json['fecha_proceso'] as String;

Map<String, dynamic> _$ItusGuionToJson(ItusGuion instance) => <String, dynamic>{
      'skill': instance.skill,
      'valor_cliente': instance.valor_cliente,
      'guion': instance.guion,
      'tipo_Persona': instance.tipo_Persona,
      'fecha_proceso': instance.fecha_proceso,
    };
