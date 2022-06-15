import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/data_layer/models/data/data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'new_model.g.dart';

@JsonSerializable()
class NewModel extends Equatable {
  final DataModel data;

  const NewModel({required this.data});
  factory NewModel.fromJson(json) => _$NewModelFromJson(json);

  @override
  List<Object?> get props => [data];
}
