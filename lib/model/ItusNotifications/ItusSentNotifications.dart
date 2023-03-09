import 'package:json_annotation/json_annotation.dart';
part 'ItusSentNotifications.g.dart';


@JsonSerializable(explicitToJson: true)
class ItusSentNotifications{


  DateTime? fecha;
  String? tipo;

  ItusSentNotifications();

  factory ItusSentNotifications.fromJson(Map<String, dynamic> json) => _$ItusSentNotificationsFromJson(json);
  Map<String, dynamic> toJson() => _$ItusSentNotificationsToJson(this);





}