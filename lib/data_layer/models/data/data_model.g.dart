// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      after: json['after'] as String,
      dist: json['dist'] as int,
      children: (json['children'] as List<dynamic>)
          .map((e) => ChildModel.fromJson(e))
          .toList(),
    );
