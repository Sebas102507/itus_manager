import 'package:json_annotation/json_annotation.dart';
part 'QueryQuestionMetadata.g.dart';

@JsonSerializable(explicitToJson: true)
class QueryQuestionMetadata{

  late int current_page;
  late int last_page;


  QueryQuestionMetadata();

  factory QueryQuestionMetadata.fromJson(Map<String, dynamic> json) => _$QueryQuestionMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$QueryQuestionMetadataToJson(this);


}