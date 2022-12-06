import 'package:json_annotation/json_annotation.dart';

part 'QueryUser.g.dart';
@JsonSerializable(explicitToJson: true)
class QueryUser {
  late int id;
  late String document;
  late String txt_tipodoc;
  late String tipo_identificacion;
  late String name;
  late String lastname;
  late String cellphone;
  late String email;
  late int allow_sms;
  late int allow_email;
  @JsonKey(ignore: true)
  late String edad;
  @JsonKey(ignore: true)
  late String  categoria_afiliacion;
  @JsonKey(ignore: true)
  late String subsidio_monetario;
  @JsonKey(ignore: true)
  late String subsidio_vivienda;
  @JsonKey(ignore: true)
  late String dapter;


  QueryUser();

  factory QueryUser.fromJson(Map<String, dynamic> json) => _$QueryUserFromJson(json);
  Map<String, dynamic> toJson() => _$QueryUserToJson(this);


  setRemainInfo(Map<String, dynamic> remainData){
    edad = remainData["edad"];
    categoria_afiliacion = remainData["categoria_afiliacion"];
    subsidio_monetario = remainData["subsidio_monetario"];
    subsidio_vivienda = remainData["subsidio_vivienda"];
    dapter = remainData["dapter"];
  }

}