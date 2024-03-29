// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int nominal) addNominalBayar,
    required TResult Function(String uuid) addUuid,
    required TResult Function(String paymentMethod, List<OrderItem> orders)
        processOrder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int nominal)? addNominalBayar,
    TResult? Function(String uuid)? addUuid,
    TResult? Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int nominal)? addNominalBayar,
    TResult Function(String uuid)? addUuid,
    TResult Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddNominalBayar value) addNominalBayar,
    required TResult Function(_AddUuid value) addUuid,
    required TResult Function(_ProcessOrder value) processOrder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddNominalBayar value)? addNominalBayar,
    TResult? Function(_AddUuid value)? addUuid,
    TResult? Function(_ProcessOrder value)? processOrder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddNominalBayar value)? addNominalBayar,
    TResult Function(_AddUuid value)? addUuid,
    TResult Function(_ProcessOrder value)? processOrder,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEventCopyWith<$Res> {
  factory $OrderEventCopyWith(
          OrderEvent value, $Res Function(OrderEvent) then) =
      _$OrderEventCopyWithImpl<$Res, OrderEvent>;
}

/// @nodoc
class _$OrderEventCopyWithImpl<$Res, $Val extends OrderEvent>
    implements $OrderEventCopyWith<$Res> {
  _$OrderEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl with DiagnosticableTreeMixin implements _Started {
  const _$StartedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderEvent.started()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'OrderEvent.started'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int nominal) addNominalBayar,
    required TResult Function(String uuid) addUuid,
    required TResult Function(String paymentMethod, List<OrderItem> orders)
        processOrder,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int nominal)? addNominalBayar,
    TResult? Function(String uuid)? addUuid,
    TResult? Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int nominal)? addNominalBayar,
    TResult Function(String uuid)? addUuid,
    TResult Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddNominalBayar value) addNominalBayar,
    required TResult Function(_AddUuid value) addUuid,
    required TResult Function(_ProcessOrder value) processOrder,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddNominalBayar value)? addNominalBayar,
    TResult? Function(_AddUuid value)? addUuid,
    TResult? Function(_ProcessOrder value)? processOrder,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddNominalBayar value)? addNominalBayar,
    TResult Function(_AddUuid value)? addUuid,
    TResult Function(_ProcessOrder value)? processOrder,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements OrderEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$AddNominalBayarImplCopyWith<$Res> {
  factory _$$AddNominalBayarImplCopyWith(_$AddNominalBayarImpl value,
          $Res Function(_$AddNominalBayarImpl) then) =
      __$$AddNominalBayarImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int nominal});
}

/// @nodoc
class __$$AddNominalBayarImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$AddNominalBayarImpl>
    implements _$$AddNominalBayarImplCopyWith<$Res> {
  __$$AddNominalBayarImplCopyWithImpl(
      _$AddNominalBayarImpl _value, $Res Function(_$AddNominalBayarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nominal = null,
  }) {
    return _then(_$AddNominalBayarImpl(
      null == nominal
          ? _value.nominal
          : nominal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddNominalBayarImpl
    with DiagnosticableTreeMixin
    implements _AddNominalBayar {
  const _$AddNominalBayarImpl(this.nominal);

  @override
  final int nominal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderEvent.addNominalBayar(nominal: $nominal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderEvent.addNominalBayar'))
      ..add(DiagnosticsProperty('nominal', nominal));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNominalBayarImpl &&
            (identical(other.nominal, nominal) || other.nominal == nominal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nominal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNominalBayarImplCopyWith<_$AddNominalBayarImpl> get copyWith =>
      __$$AddNominalBayarImplCopyWithImpl<_$AddNominalBayarImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int nominal) addNominalBayar,
    required TResult Function(String uuid) addUuid,
    required TResult Function(String paymentMethod, List<OrderItem> orders)
        processOrder,
  }) {
    return addNominalBayar(nominal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int nominal)? addNominalBayar,
    TResult? Function(String uuid)? addUuid,
    TResult? Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
  }) {
    return addNominalBayar?.call(nominal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int nominal)? addNominalBayar,
    TResult Function(String uuid)? addUuid,
    TResult Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
    required TResult orElse(),
  }) {
    if (addNominalBayar != null) {
      return addNominalBayar(nominal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddNominalBayar value) addNominalBayar,
    required TResult Function(_AddUuid value) addUuid,
    required TResult Function(_ProcessOrder value) processOrder,
  }) {
    return addNominalBayar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddNominalBayar value)? addNominalBayar,
    TResult? Function(_AddUuid value)? addUuid,
    TResult? Function(_ProcessOrder value)? processOrder,
  }) {
    return addNominalBayar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddNominalBayar value)? addNominalBayar,
    TResult Function(_AddUuid value)? addUuid,
    TResult Function(_ProcessOrder value)? processOrder,
    required TResult orElse(),
  }) {
    if (addNominalBayar != null) {
      return addNominalBayar(this);
    }
    return orElse();
  }
}

abstract class _AddNominalBayar implements OrderEvent {
  const factory _AddNominalBayar(final int nominal) = _$AddNominalBayarImpl;

  int get nominal;
  @JsonKey(ignore: true)
  _$$AddNominalBayarImplCopyWith<_$AddNominalBayarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddUuidImplCopyWith<$Res> {
  factory _$$AddUuidImplCopyWith(
          _$AddUuidImpl value, $Res Function(_$AddUuidImpl) then) =
      __$$AddUuidImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String uuid});
}

/// @nodoc
class __$$AddUuidImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$AddUuidImpl>
    implements _$$AddUuidImplCopyWith<$Res> {
  __$$AddUuidImplCopyWithImpl(
      _$AddUuidImpl _value, $Res Function(_$AddUuidImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
  }) {
    return _then(_$AddUuidImpl(
      null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddUuidImpl with DiagnosticableTreeMixin implements _AddUuid {
  const _$AddUuidImpl(this.uuid);

  @override
  final String uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderEvent.addUuid(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderEvent.addUuid'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddUuidImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddUuidImplCopyWith<_$AddUuidImpl> get copyWith =>
      __$$AddUuidImplCopyWithImpl<_$AddUuidImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int nominal) addNominalBayar,
    required TResult Function(String uuid) addUuid,
    required TResult Function(String paymentMethod, List<OrderItem> orders)
        processOrder,
  }) {
    return addUuid(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int nominal)? addNominalBayar,
    TResult? Function(String uuid)? addUuid,
    TResult? Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
  }) {
    return addUuid?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int nominal)? addNominalBayar,
    TResult Function(String uuid)? addUuid,
    TResult Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
    required TResult orElse(),
  }) {
    if (addUuid != null) {
      return addUuid(uuid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddNominalBayar value) addNominalBayar,
    required TResult Function(_AddUuid value) addUuid,
    required TResult Function(_ProcessOrder value) processOrder,
  }) {
    return addUuid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddNominalBayar value)? addNominalBayar,
    TResult? Function(_AddUuid value)? addUuid,
    TResult? Function(_ProcessOrder value)? processOrder,
  }) {
    return addUuid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddNominalBayar value)? addNominalBayar,
    TResult Function(_AddUuid value)? addUuid,
    TResult Function(_ProcessOrder value)? processOrder,
    required TResult orElse(),
  }) {
    if (addUuid != null) {
      return addUuid(this);
    }
    return orElse();
  }
}

abstract class _AddUuid implements OrderEvent {
  const factory _AddUuid(final String uuid) = _$AddUuidImpl;

  String get uuid;
  @JsonKey(ignore: true)
  _$$AddUuidImplCopyWith<_$AddUuidImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessOrderImplCopyWith<$Res> {
  factory _$$ProcessOrderImplCopyWith(
          _$ProcessOrderImpl value, $Res Function(_$ProcessOrderImpl) then) =
      __$$ProcessOrderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String paymentMethod, List<OrderItem> orders});
}

/// @nodoc
class __$$ProcessOrderImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$ProcessOrderImpl>
    implements _$$ProcessOrderImplCopyWith<$Res> {
  __$$ProcessOrderImplCopyWithImpl(
      _$ProcessOrderImpl _value, $Res Function(_$ProcessOrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = null,
    Object? orders = null,
  }) {
    return _then(_$ProcessOrderImpl(
      null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
    ));
  }
}

/// @nodoc

class _$ProcessOrderImpl with DiagnosticableTreeMixin implements _ProcessOrder {
  const _$ProcessOrderImpl(this.paymentMethod, final List<OrderItem> orders)
      : _orders = orders;

  @override
  final String paymentMethod;
  final List<OrderItem> _orders;
  @override
  List<OrderItem> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderEvent.processOrder(paymentMethod: $paymentMethod, orders: $orders)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderEvent.processOrder'))
      ..add(DiagnosticsProperty('paymentMethod', paymentMethod))
      ..add(DiagnosticsProperty('orders', orders));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessOrderImpl &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, paymentMethod, const DeepCollectionEquality().hash(_orders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessOrderImplCopyWith<_$ProcessOrderImpl> get copyWith =>
      __$$ProcessOrderImplCopyWithImpl<_$ProcessOrderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int nominal) addNominalBayar,
    required TResult Function(String uuid) addUuid,
    required TResult Function(String paymentMethod, List<OrderItem> orders)
        processOrder,
  }) {
    return processOrder(paymentMethod, orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int nominal)? addNominalBayar,
    TResult? Function(String uuid)? addUuid,
    TResult? Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
  }) {
    return processOrder?.call(paymentMethod, orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int nominal)? addNominalBayar,
    TResult Function(String uuid)? addUuid,
    TResult Function(String paymentMethod, List<OrderItem> orders)?
        processOrder,
    required TResult orElse(),
  }) {
    if (processOrder != null) {
      return processOrder(paymentMethod, orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddNominalBayar value) addNominalBayar,
    required TResult Function(_AddUuid value) addUuid,
    required TResult Function(_ProcessOrder value) processOrder,
  }) {
    return processOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddNominalBayar value)? addNominalBayar,
    TResult? Function(_AddUuid value)? addUuid,
    TResult? Function(_ProcessOrder value)? processOrder,
  }) {
    return processOrder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddNominalBayar value)? addNominalBayar,
    TResult Function(_AddUuid value)? addUuid,
    TResult Function(_ProcessOrder value)? processOrder,
    required TResult orElse(),
  }) {
    if (processOrder != null) {
      return processOrder(this);
    }
    return orElse();
  }
}

abstract class _ProcessOrder implements OrderEvent {
  const factory _ProcessOrder(
          final String paymentMethod, final List<OrderItem> orders) =
      _$ProcessOrderImpl;

  String get paymentMethod;
  List<OrderItem> get orders;
  @JsonKey(ignore: true)
  _$$ProcessOrderImplCopyWith<_$ProcessOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
          OrderState value, $Res Function(OrderState) then) =
      _$OrderStateCopyWithImpl<$Res, OrderState>;
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res, $Val extends OrderState>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'OrderState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)
        success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OrderState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'OrderState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)
        success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements OrderState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<OrderItem> products,
      int totalQuantity,
      int totalPrice,
      String paymentMethod,
      int nominalBayar,
      int idKasir,
      String namaKasir,
      String uuid});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? totalQuantity = null,
    Object? totalPrice = null,
    Object? paymentMethod = null,
    Object? nominalBayar = null,
    Object? idKasir = null,
    Object? namaKasir = null,
    Object? uuid = null,
  }) {
    return _then(_$SuccessImpl(
      null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
      null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      null == nominalBayar
          ? _value.nominalBayar
          : nominalBayar // ignore: cast_nullable_to_non_nullable
              as int,
      null == idKasir
          ? _value.idKasir
          : idKasir // ignore: cast_nullable_to_non_nullable
              as int,
      null == namaKasir
          ? _value.namaKasir
          : namaKasir // ignore: cast_nullable_to_non_nullable
              as String,
      null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl with DiagnosticableTreeMixin implements _Success {
  const _$SuccessImpl(
      final List<OrderItem> products,
      this.totalQuantity,
      this.totalPrice,
      this.paymentMethod,
      this.nominalBayar,
      this.idKasir,
      this.namaKasir,
      this.uuid)
      : _products = products;

  final List<OrderItem> _products;
  @override
  List<OrderItem> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final int totalQuantity;
  @override
  final int totalPrice;
  @override
  final String paymentMethod;
  @override
  final int nominalBayar;
  @override
  final int idKasir;
  @override
  final String namaKasir;
  @override
  final String uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderState.success(products: $products, totalQuantity: $totalQuantity, totalPrice: $totalPrice, paymentMethod: $paymentMethod, nominalBayar: $nominalBayar, idKasir: $idKasir, namaKasir: $namaKasir, uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderState.success'))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('totalQuantity', totalQuantity))
      ..add(DiagnosticsProperty('totalPrice', totalPrice))
      ..add(DiagnosticsProperty('paymentMethod', paymentMethod))
      ..add(DiagnosticsProperty('nominalBayar', nominalBayar))
      ..add(DiagnosticsProperty('idKasir', idKasir))
      ..add(DiagnosticsProperty('namaKasir', namaKasir))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.nominalBayar, nominalBayar) ||
                other.nominalBayar == nominalBayar) &&
            (identical(other.idKasir, idKasir) || other.idKasir == idKasir) &&
            (identical(other.namaKasir, namaKasir) ||
                other.namaKasir == namaKasir) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      totalQuantity,
      totalPrice,
      paymentMethod,
      nominalBayar,
      idKasir,
      namaKasir,
      uuid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)
        success,
    required TResult Function(String message) error,
  }) {
    return success(products, totalQuantity, totalPrice, paymentMethod,
        nominalBayar, idKasir, namaKasir, uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(products, totalQuantity, totalPrice, paymentMethod,
        nominalBayar, idKasir, namaKasir, uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(products, totalQuantity, totalPrice, paymentMethod,
          nominalBayar, idKasir, namaKasir, uuid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements OrderState {
  const factory _Success(
      final List<OrderItem> products,
      final int totalQuantity,
      final int totalPrice,
      final String paymentMethod,
      final int nominalBayar,
      final int idKasir,
      final String namaKasir,
      final String uuid) = _$SuccessImpl;

  List<OrderItem> get products;
  int get totalQuantity;
  int get totalPrice;
  String get paymentMethod;
  int get nominalBayar;
  int get idKasir;
  String get namaKasir;
  String get uuid;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)
        success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OrderItem> products,
            int totalQuantity,
            int totalPrice,
            String paymentMethod,
            int nominalBayar,
            int idKasir,
            String namaKasir,
            String uuid)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements OrderState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
