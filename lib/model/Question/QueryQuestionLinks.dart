import 'package:json_annotation/json_annotation.dart';
part 'QueryQuestionLinks.g.dart';

@JsonSerializable(explicitToJson: true)
class QueryQuestionLinks{

  late String first;
  late String last;
  String? prev;
  String? next;

  QueryQuestionLinks();

  factory QueryQuestionLinks.fromJson(Map<String, dynamic> json) => _$QueryQuestionLinksFromJson(json);
  Map<String, dynamic> toJson() => _$QueryQuestionLinksToJson(this);


}