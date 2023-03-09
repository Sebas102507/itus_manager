// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itus_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItusNotification _$ItusNotificationFromJson(Map<String, dynamic> json) =>
    ItusNotification()
      ..titulo_notificacion = json['titulo_notificacion'] as String?
      ..fechain = json['fechain'] == null
          ? null
          : DateTime.parse(json['fechain'] as String)
      ..ciclo_negocio = json['ciclo_negocio'] as String?;

Map<String, dynamic> _$ItusNotificationToJson(ItusNotification instance) =>
    <String, dynamic>{
      'titulo_notificacion': instance.titulo_notificacion,
      'fechain': instance.fechain?.toIso8601String(),
      'ciclo_negocio': instance.ciclo_negocio,
    };
