// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo(
  title: json['title'] as String,
  isDone: json['isDone'] as bool,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
  'title': instance.title,
  'isDone': instance.isDone,
  'id': instance.id,
};
