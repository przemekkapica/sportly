// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_action.f.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
    required TResult Function() online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppActionOffline value) offline,
    required TResult Function(AppActionOnline value) online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppActionOffline value)? offline,
    TResult Function(AppActionOnline value)? online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppActionOffline value)? offline,
    TResult Function(AppActionOnline value)? online,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppActionCopyWith<$Res> {
  factory $AppActionCopyWith(AppAction value, $Res Function(AppAction) then) =
      _$AppActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppActionCopyWithImpl<$Res> implements $AppActionCopyWith<$Res> {
  _$AppActionCopyWithImpl(this._value, this._then);

  final AppAction _value;
  // ignore: unused_field
  final $Res Function(AppAction) _then;
}

/// @nodoc
abstract class _$$AppActionOfflineCopyWith<$Res> {
  factory _$$AppActionOfflineCopyWith(
          _$AppActionOffline value, $Res Function(_$AppActionOffline) then) =
      __$$AppActionOfflineCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppActionOfflineCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res>
    implements _$$AppActionOfflineCopyWith<$Res> {
  __$$AppActionOfflineCopyWithImpl(
      _$AppActionOffline _value, $Res Function(_$AppActionOffline) _then)
      : super(_value, (v) => _then(v as _$AppActionOffline));

  @override
  _$AppActionOffline get _value => super._value as _$AppActionOffline;
}

/// @nodoc

class _$AppActionOffline implements AppActionOffline {
  const _$AppActionOffline();

  @override
  String toString() {
    return 'AppAction.offline()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppActionOffline);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
    required TResult Function() online,
  }) {
    return offline();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
  }) {
    return offline?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppActionOffline value) offline,
    required TResult Function(AppActionOnline value) online,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppActionOffline value)? offline,
    TResult Function(AppActionOnline value)? online,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppActionOffline value)? offline,
    TResult Function(AppActionOnline value)? online,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class AppActionOffline implements AppAction {
  const factory AppActionOffline() = _$AppActionOffline;
}

/// @nodoc
abstract class _$$AppActionOnlineCopyWith<$Res> {
  factory _$$AppActionOnlineCopyWith(
          _$AppActionOnline value, $Res Function(_$AppActionOnline) then) =
      __$$AppActionOnlineCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppActionOnlineCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res>
    implements _$$AppActionOnlineCopyWith<$Res> {
  __$$AppActionOnlineCopyWithImpl(
      _$AppActionOnline _value, $Res Function(_$AppActionOnline) _then)
      : super(_value, (v) => _then(v as _$AppActionOnline));

  @override
  _$AppActionOnline get _value => super._value as _$AppActionOnline;
}

/// @nodoc

class _$AppActionOnline implements AppActionOnline {
  const _$AppActionOnline();

  @override
  String toString() {
    return 'AppAction.online()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppActionOnline);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
    required TResult Function() online,
  }) {
    return online();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
  }) {
    return online?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
    required TResult orElse(),
  }) {
    if (online != null) {
      return online();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppActionOffline value) offline,
    required TResult Function(AppActionOnline value) online,
  }) {
    return online(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppActionOffline value)? offline,
    TResult Function(AppActionOnline value)? online,
  }) {
    return online?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppActionOffline value)? offline,
    TResult Function(AppActionOnline value)? online,
    required TResult orElse(),
  }) {
    if (online != null) {
      return online(this);
    }
    return orElse();
  }
}

abstract class AppActionOnline implements AppAction {
  const factory AppActionOnline() = _$AppActionOnline;
}
