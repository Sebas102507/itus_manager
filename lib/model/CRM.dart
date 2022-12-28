import 'package:json_annotation/json_annotation.dart';
part 'CRM.g.dart';

@JsonSerializable(explicitToJson: true)

class CRM{

  late String ciclo_negocio;

  late String descripcion_caso;

  late String resumen;

  late String medio_respuesta;

  late DateTime fecha_envio;

  late DateTime fecha_cierre;

  CRM();

  factory CRM.fromJson(Map<String, dynamic> json) => _$CRMFromJson(json);
  Map<String, dynamic> toJson() => _$CRMToJson(this);



}