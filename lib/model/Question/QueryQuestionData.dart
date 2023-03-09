import 'package:itus_manager/model/question/QueryQuestion.dart';
import 'package:itus_manager/model/question/QueryQuestionLinks.dart';
import 'package:itus_manager/model/question/QueryQuestionMetadata.dart';
import 'package:json_annotation/json_annotation.dart';
part 'QueryQuestionData.g.dart';

@JsonSerializable(explicitToJson: true)
class QueryQuestionData{


  late List<QueryQuestion> data;
  late QueryQuestionLinks links;
  late QueryQuestionMetadata meta;


  QueryQuestionData();

  factory QueryQuestionData.fromJson(Map<String, dynamic> json) => _$QueryQuestionDataFromJson(json);
  Map<String, dynamic> toJson() => _$QueryQuestionDataToJson(this);

}