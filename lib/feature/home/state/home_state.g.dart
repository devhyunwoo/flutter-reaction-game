// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeStateImpl _$$HomeStateImplFromJson(Map<String, dynamic> json) =>
    _$HomeStateImpl(
      timeStamp: (json['timeStamp'] as num?)?.toInt() ?? 0,
      isStart: json['isStart'] as bool? ?? false,
      isEnd: json['isEnd'] as bool? ?? false,
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'timeStamp': instance.timeStamp,
      'isStart': instance.isStart,
      'isEnd': instance.isEnd,
    };
