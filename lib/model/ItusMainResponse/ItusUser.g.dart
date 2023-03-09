// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItusUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItusUser _$ItusUserFromJson(Map<String, dynamic> json) => ItusUser()
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..documento = json['documento'] as String
  ..apellido1 = json['apellido1'] as String
  ..apellido2 = json['apellido2'] as String
  ..tipo = json['tipo'] as String
  ..cambio_pass = json['cambio_pass'] as String
  ..rol = json['rol'] as String
  ..active = json['active'] as String
  ..ciclo = (json['ciclo'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$ItusUserToJson(ItusUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'documento': instance.documento,
      'apellido1': instance.apellido1,
      'apellido2': instance.apellido2,
      'tipo': instance.tipo,
      'cambio_pass': instance.cambio_pass,
      'rol': instance.rol,
      'active': instance.active,
      'ciclo': instance.ciclo,
    };
