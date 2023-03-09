// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QueryBusiness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryBusiness _$QueryBusinessFromJson(Map<String, dynamic> json) =>
    QueryBusiness()
      ..tipo_identificacion = json['tipo_identificacion'] as int
      ..identificacion = json['identificacion'] as String
      ..nombre_empresa = json['nombre_empresa'] as String
      ..celular = json['celular'] as String
      ..email = json['email'] as String
      ..segmento = json['segmento'] as String
      ..cantidad_trabajadores = json['cantidad_trabajadores'] as int
      ..act_economica = json['act_economica'] as String
      ..barrio = json['barrio'] as String
      ..direccion = json['direccion'] as String
      ..asesor_pac = json['asesor_pac'] as String?
      ..autorizacion_celular = json['autorizacion_celular'] as String
      ..autorizacion_email = json['autorizacion_email'] as String
      ..contacts = (json['contacts'] as List<dynamic>)
          .map((e) => QueryBusinessContact.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$QueryBusinessToJson(QueryBusiness instance) =>
    <String, dynamic>{
      'tipo_identificacion': instance.tipo_identificacion,
      'identificacion': instance.identificacion,
      'nombre_empresa': instance.nombre_empresa,
      'celular': instance.celular,
      'email': instance.email,
      'segmento': instance.segmento,
      'cantidad_trabajadores': instance.cantidad_trabajadores,
      'act_economica': instance.act_economica,
      'barrio': instance.barrio,
      'direccion': instance.direccion,
      'asesor_pac': instance.asesor_pac,
      'autorizacion_celular': instance.autorizacion_celular,
      'autorizacion_email': instance.autorizacion_email,
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
    };
