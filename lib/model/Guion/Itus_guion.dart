import 'package:json_annotation/json_annotation.dart';

part 'Itus_guion.g.dart';
@JsonSerializable(explicitToJson: true)
class ItusGuion{

  late String skill;
  late String valor_cliente;
  late String guion;
  late String tipo_Persona;
  late String fecha_proceso;


  ItusGuion();

  factory ItusGuion.fromJson(Map<String, dynamic> json) => _$ItusGuionFromJson(json);
  Map<String, dynamic> toJson() => _$ItusGuionToJson(this);



}