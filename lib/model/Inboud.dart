import 'package:json_annotation/json_annotation.dart';
part 'Inboud.g.dart';


@JsonSerializable(explicitToJson: true)
class Inbound{

  late String linea;

  late String medio;

  late DateTime fecha_envio;

  late String resumen;

  Inbound();

  factory Inbound.fromJson(Map<String, dynamic> json) => _$InboundFromJson(json);
  Map<String, dynamic> toJson() => _$InboundToJson(this);


}