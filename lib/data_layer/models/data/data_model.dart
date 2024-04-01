import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../child/child_model.dart';
part 'data_model.g.dart';

@JsonSerializable()
class DataModel extends Equatable {
  final String after;
  final int dist;
  final List<ChildModel> children;

  const DataModel({
    required this.after,
    required this.dist,
    required this.children,
  });

  factory DataModel.fromJson(json) => _$DataModelFromJson(json);

  @override
  List<Object?> get props => [
        after,
        dist,
        children,
      ];
}
