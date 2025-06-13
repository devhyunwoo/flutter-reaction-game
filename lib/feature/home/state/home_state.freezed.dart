// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeState {
  GameStatus get status => throw _privateConstructorUsedError; // 🎯 initial로 시작
  int get reactionTime => throw _privateConstructorUsedError;
  int get startTimeStamp => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({GameStatus status, int reactionTime, int startTimeStamp});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? reactionTime = null,
    Object? startTimeStamp = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GameStatus,
            reactionTime: null == reactionTime
                ? _value.reactionTime
                : reactionTime // ignore: cast_nullable_to_non_nullable
                      as int,
            startTimeStamp: null == startTimeStamp
                ? _value.startTimeStamp
                : startTimeStamp // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
    _$HomeStateImpl value,
    $Res Function(_$HomeStateImpl) then,
  ) = __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameStatus status, int reactionTime, int startTimeStamp});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
    _$HomeStateImpl _value,
    $Res Function(_$HomeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? reactionTime = null,
    Object? startTimeStamp = null,
  }) {
    return _then(
      _$HomeStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GameStatus,
        reactionTime: null == reactionTime
            ? _value.reactionTime
            : reactionTime // ignore: cast_nullable_to_non_nullable
                  as int,
        startTimeStamp: null == startTimeStamp
            ? _value.startTimeStamp
            : startTimeStamp // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl({
    this.status = GameStatus.initial,
    this.reactionTime = 0,
    this.startTimeStamp = 0,
  });

  @override
  @JsonKey()
  final GameStatus status;
  // 🎯 initial로 시작
  @override
  @JsonKey()
  final int reactionTime;
  @override
  @JsonKey()
  final int startTimeStamp;

  @override
  String toString() {
    return 'HomeState(status: $status, reactionTime: $reactionTime, startTimeStamp: $startTimeStamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reactionTime, reactionTime) ||
                other.reactionTime == reactionTime) &&
            (identical(other.startTimeStamp, startTimeStamp) ||
                other.startTimeStamp == startTimeStamp));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, reactionTime, startTimeStamp);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({
    final GameStatus status,
    final int reactionTime,
    final int startTimeStamp,
  }) = _$HomeStateImpl;

  @override
  GameStatus get status; // 🎯 initial로 시작
  @override
  int get reactionTime;
  @override
  int get startTimeStamp;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
