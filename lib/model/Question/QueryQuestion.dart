import 'package:json_annotation/json_annotation.dart';
part 'QueryQuestion.g.dart';

@JsonSerializable(explicitToJson: true)
class QueryQuestion{

  late int id;
  late String question;
  late String answer;
  late String campaign;
  late String business;
  late String validate_optin;

  QueryQuestion();

  factory QueryQuestion.fromJson(Map<String, dynamic> json) => _$QueryQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QueryQuestionToJson(this);

}