// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItusSentNotifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItusSentNotifications _$ItusSentNotificationsFromJson(
        Map<String, dynamic> json) =>
    ItusSentNotifications()
      ..fecha =
          json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String)
      ..tipo = json['tipo'] as String?;

Map<String, dynamic> _$ItusSentNotificationsToJson(
        ItusSentNotifications instance) =>
    <String, dynamic>{
      'fecha': instance.fecha?.toIso8601String(),
      'tipo': instance.tipo,
    };
