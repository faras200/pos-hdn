import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/presentations/home/models/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Success([], 0, 0, '', 0, 0, '')) {
    on<_AddPaymentMethod>((event, emit) {
      emit(const _Loading());
      emit(_Success(
        event.orders,
        event.orders.fold(
            0, (previousValue, element) => previousValue + element.quantity),
        event.orders.fold(
            0,
            (previousValue, element) =>
                previousValue +
                (element.quantity * int.parse(element.product.harga))),
        event.paymentMethod,
        0,
        0,
        '',
      ));
    });

    on<_AddNominalBayar>((event, emit) {
      var currentStates = state as _Success;
      emit(const _Loading());

      emit(_Success(
        currentStates.products,
        currentStates.totalQuantity,
        currentStates.totalPrice,
        currentStates.paymentMethod,
        event.nominal,
        currentStates.idKasir,
        currentStates.namaKasir,
      ));
    });

    //started
    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success([], 0, 0, '', 0, 0, ''));
    });
  }
}
