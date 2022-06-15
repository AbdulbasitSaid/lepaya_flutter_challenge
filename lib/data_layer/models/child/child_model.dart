import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../child_data/child_data_model.dart';
part 'child_model.g.dart';

@JsonSerializable()
class ChildModel extends Equatable {
  final ChildDataModel data;

  const ChildModel({required this.data});
  factory ChildModel.fromJson(json) => _$ChildModelFromJson(json);

  @override
  List<Object?> get props => [data];
}
