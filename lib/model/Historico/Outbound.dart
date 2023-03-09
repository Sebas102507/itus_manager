import 'package:json_annotation/json_annotation.dart';
part 'Outbound.g.dart';

@JsonSerializable(explicitToJson: true)
class Outbound{

  String? fuente;

  String? medio;

  String? resumen;

  DateTime? fecha_envio;

  String? mensaje;

  DateTime? fechain;

  Outbound();

  factory Outbound.fromJson(Map<String, dynamic> json) => _$OutboundFromJson(json);
  Map<String, dynamic> toJson() => _$OutboundToJson(this);


}