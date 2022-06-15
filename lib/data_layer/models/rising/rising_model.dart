import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../data/data_model.dart';
part 'rising_model.g.dart';

@JsonSerializable()
class RisingModel extends Equatable {
  final DataModel data;

  const RisingModel({required this.data});
  factory RisingModel.fromJson(json) => _$RisingModelFromJson(json);

  @override
  List<Object?> get props => [data];
}
