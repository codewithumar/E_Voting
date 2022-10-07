// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'votecountmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VoteCountModel _$VoteCountModelFromJson(Map<String, dynamic> json) {
  return _TestClass.fromJson(json);
}

/// @nodoc
mixin _$VoteCountModel {
  String get partyid => throw _privateConstructorUsedError;
  String get partyname => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoteCountModelCopyWith<VoteCountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteCountModelCopyWith<$Res> {
  factory $VoteCountModelCopyWith(
          VoteCountModel value, $Res Function(VoteCountModel) then) =
      _$VoteCountModelCopyWithImpl<$Res>;
  $Res call({String partyid, String partyname, DateTime datetime});
}

/// @nodoc
class _$VoteCountModelCopyWithImpl<$Res>
    implements $VoteCountModelCopyWith<$Res> {
  _$VoteCountModelCopyWithImpl(this._value, this._then);

  final VoteCountModel _value;
  // ignore: unused_field
  final $Res Function(VoteCountModel) _then;

  @override
  $Res call({
    Object? partyid = freezed,
    Object? partyname = freezed,
    Object? datetime = freezed,
  }) {
    return _then(_value.copyWith(
      partyid: partyid == freezed
          ? _value.partyid
          : partyid // ignore: cast_nullable_to_non_nullable
              as String,
      partyname: partyname == freezed
          ? _value.partyname
          : partyname // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: datetime == freezed
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_TestClassCopyWith<$Res>
    implements $VoteCountModelCopyWith<$Res> {
  factory _$$_TestClassCopyWith(
          _$_TestClass value, $Res Function(_$_TestClass) then) =
      __$$_TestClassCopyWithImpl<$Res>;
  @override
  $Res call({String partyid, String partyname, DateTime datetime});
}

/// @nodoc
class __$$_TestClassCopyWithImpl<$Res>
    extends _$VoteCountModelCopyWithImpl<$Res>
    implements _$$_TestClassCopyWith<$Res> {
  __$$_TestClassCopyWithImpl(
      _$_TestClass _value, $Res Function(_$_TestClass) _then)
      : super(_value, (v) => _then(v as _$_TestClass));

  @override
  _$_TestClass get _value => super._value as _$_TestClass;

  @override
  $Res call({
    Object? partyid = freezed,
    Object? partyname = freezed,
    Object? datetime = freezed,
  }) {
    return _then(_$_TestClass(
      partyid: partyid == freezed
          ? _value.partyid
          : partyid // ignore: cast_nullable_to_non_nullable
              as String,
      partyname: partyname == freezed
          ? _value.partyname
          : partyname // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: datetime == freezed
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TestClass implements _TestClass {
  const _$_TestClass(
      {required this.partyid, required this.partyname, required this.datetime});

  factory _$_TestClass.fromJson(Map<String, dynamic> json) =>
      _$$_TestClassFromJson(json);

  @override
  final String partyid;
  @override
  final String partyname;
  @override
  final DateTime datetime;

  @override
  String toString() {
    return 'VoteCountModel(partyid: $partyid, partyname: $partyname, datetime: $datetime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TestClass &&
            const DeepCollectionEquality().equals(other.partyid, partyid) &&
            const DeepCollectionEquality().equals(other.partyname, partyname) &&
            const DeepCollectionEquality().equals(other.datetime, datetime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(partyid),
      const DeepCollectionEquality().hash(partyname),
      const DeepCollectionEquality().hash(datetime));

  @JsonKey(ignore: true)
  @override
  _$$_TestClassCopyWith<_$_TestClass> get copyWith =>
      __$$_TestClassCopyWithImpl<_$_TestClass>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TestClassToJson(
      this,
    );
  }
}

abstract class _TestClass implements VoteCountModel {
  const factory _TestClass(
      {required final String partyid,
      required final String partyname,
      required final DateTime datetime}) = _$_TestClass;

  factory _TestClass.fromJson(Map<String, dynamic> json) =
      _$_TestClass.fromJson;

  @override
  String get partyid;
  @override
  String get partyname;
  @override
  DateTime get datetime;
  @override
  @JsonKey(ignore: true)
  _$$_TestClassCopyWith<_$_TestClass> get copyWith =>
      throw _privateConstructorUsedError;
}
