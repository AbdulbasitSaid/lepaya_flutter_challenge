import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'child_data_model.g.dart';

@JsonSerializable()
class ChildDataModel extends Equatable {
  final String selftext;
  final String title;
  final String name;
  final String permalink;
  final String url;
  String get getPostContent => selftext.isEmpty ? title : selftext;
  const ChildDataModel({
    required this.selftext,
    required this.title,
    required this.name,
    required this.permalink,
    required this.url,
  });
  factory ChildDataModel.fromJson(json) => _$ChildDataModelFromJson(json);

  @override
  List<Object?> get props => [
        selftext,
        title,
        name,
        permalink,
        url,
      ];
}
