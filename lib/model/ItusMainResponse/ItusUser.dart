import 'package:json_annotation/json_annotation.dart';

part 'ItusUser.g.dart';
@JsonSerializable(explicitToJson: true)

class ItusUser{
  late int id;
  late String name;
  late String email;
  late String documento;
  late String apellido1;
  late String apellido2;
  late String tipo;
  late String cambio_pass;
  late String rol;
  late String active;
  late List<String> ciclo;

  ItusUser();

  factory ItusUser.fromJson(Map<String, dynamic> json) => _$ItusUserFromJson(json);
  Map<String, dynamic> toJson() => _$ItusUserToJson(this);


}