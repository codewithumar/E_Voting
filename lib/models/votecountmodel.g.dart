// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'votecountmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TestClass _$$_TestClassFromJson(Map<String, dynamic> json) => _$_TestClass(
      partyid: json['partyid'] as String,
      partyname: json['partyname'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$$_TestClassToJson(_$_TestClass instance) =>
    <String, dynamic>{
      'partyid': instance.partyid,
      'partyname': instance.partyname,
      'datetime': instance.datetime.toIso8601String(),
    };
