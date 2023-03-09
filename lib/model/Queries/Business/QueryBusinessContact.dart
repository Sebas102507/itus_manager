import 'package:json_annotation/json_annotation.dart';
part 'QueryBusinessContact.g.dart';

@JsonSerializable(explicitToJson: true)

class QueryBusinessContact{

  late String nautcli_empresa;

  late String nautcli;

  late int tipo_identificacion;

  late String persona_contacto;

  late String datper;

  late String cargo_contacto;

  late String celular_contacto;

  late String email_contacto;


  QueryBusinessContact();

  factory QueryBusinessContact.fromJson(Map<String, dynamic> json) => _$QueryBusinessContactFromJson(json);
  Map<String, dynamic> toJson() => _$QueryBusinessContactToJson(this);


}