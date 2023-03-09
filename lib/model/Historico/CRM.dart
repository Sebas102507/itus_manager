import 'package:json_annotation/json_annotation.dart';
part 'CRM.g.dart';

@JsonSerializable(explicitToJson: true)

class CRM{

  String? ciclo_negocio;

  String? descripcion_caso;

  String? resumen;

  String? medio_respuesta;

  DateTime? fecha_envio;

  DateTime? fecha_cierre;

  CRM();

  factory CRM.fromJson(Map<String, dynamic> json) => _$CRMFromJson(json);
  Map<String, dynamic> toJson() => _$CRMToJson(this);



}