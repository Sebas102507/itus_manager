import 'package:json_annotation/json_annotation.dart';
import 'QueryBusinessContact.dart';
part 'QueryBusiness.g.dart';

@JsonSerializable(explicitToJson: true)

class QueryBusiness{

  late int tipo_identificacion;

  @JsonKey(ignore: true)
  late String description_indentificacion;

  @JsonKey(ignore: true)
  late String alias_indentificacion;

  late String identificacion;

  late String nombre_empresa;

  late String celular;

  late String email;

  late String segmento;

  late int cantidad_trabajadores;

  late String act_economica;

  late String barrio;

  late String direccion;

  String? asesor_pac;

  late String autorizacion_celular;

  late String autorizacion_email;

  late List<QueryBusinessContact> contacts;


  QueryBusiness();

  factory QueryBusiness.fromJson(Map<String, dynamic> json) => _$QueryBusinessFromJson(json);
  Map<String, dynamic> toJson() => _$QueryBusinessToJson(this);

}