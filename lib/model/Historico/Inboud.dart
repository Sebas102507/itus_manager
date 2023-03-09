import 'package:json_annotation/json_annotation.dart';
part 'Inboud.g.dart';


@JsonSerializable(explicitToJson: true)
class Inbound{

  String? linea;

  String? medio;

  DateTime? fecha_envio;

  String? resumen;

  Inbound();

  factory Inbound.fromJson(Map<String, dynamic> json) => _$InboundFromJson(json);
  Map<String, dynamic> toJson() => _$InboundToJson(this);


}