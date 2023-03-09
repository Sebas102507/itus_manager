import 'package:json_annotation/json_annotation.dart';
part 'itus_notification.g.dart';


@JsonSerializable(explicitToJson: true)
class ItusNotification{


  String? titulo_notificacion;
  DateTime? fechain;
  String? ciclo_negocio;

  ItusNotification();

  factory ItusNotification.fromJson(Map<String, dynamic> json) => _$ItusNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$ItusNotificationToJson(this);

}