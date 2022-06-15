import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/data_layer/models/data/data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'hot_model.g.dart';

@JsonSerializable()
class HotModel extends Equatable {
  final DataModel data;

  const HotModel({required this.data});

  factory HotModel.fromJson(json) => _$HotModelFromJson(json);

  @override
  List<Object?> get props => [data];
}
