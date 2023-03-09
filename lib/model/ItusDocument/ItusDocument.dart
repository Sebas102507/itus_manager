import 'package:json_annotation/json_annotation.dart';
part 'ItusDocument.g.dart';

@JsonSerializable(explicitToJson: true)

class ItusDocument{

  late int id_document;

  late String description;

  late String alias;

  ItusDocument();


  ItusDocument.init(this.id_document, this.description, this.alias);

  factory ItusDocument.fromJson(Map<String, dynamic> json) => _$ItusDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$ItusDocumentToJson(this);

  @override
  bool operator ==(Object other) =>
      other is ItusDocument && id_document == other.id_document;

  @override
  int get hashCode => super.hashCode;





}