import 'package:json_annotation/json_annotation.dart';
part 'Outbound.g.dart';

@JsonSerializable(explicitToJson: true)
class Outbound{

  late String fuente;

  late String medio;

  late String resumen;

  late DateTime fecha_envio;

  late String mensaje;

  late DateTime fechain;

  Outbound();

  factory Outbound.fromJson(Map<String, dynamic> json) => _$OutboundFromJson(json);
  Map<String, dynamic> toJson() => _$OutboundToJson(this);


}