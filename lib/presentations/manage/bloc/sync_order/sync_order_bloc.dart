import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/order_remote_datasource.dart';
import 'package:pos_hdn/data/models/request/order_request_model.dart';

part 'sync_order_bloc.freezed.dart';
part 'sync_order_event.dart';
part 'sync_order_state.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  SyncOrderBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_SendOrder>((event, emit) async {
      emit(const SyncOrderState.loading());
      //get orders from local is sync is 0
      final ordersIsSyncZero =
          await OrderLocalDatasource.instance.getOrderByIsSync();

      if (ordersIsSyncZero.isEmpty) {
        return emit(const SyncOrderState.success());
      }

      for (final order in ordersIsSyncZero) {
        final orderItems = await OrderLocalDatasource.instance
            .getOrderItemByOrderIdLocal(order.id!);

        final orderRequest = OrderRequestModel(
            uuid: order.uuid!,
            transactionTime: order.transactionTime!,
            totalItem: order.totalQuantity!,
            totalPrice: order.totalPrice!,
            kasirId: order.idKasir!,
            paymentMethod: order.paymentMethod!,
            orderItems: orderItems);
        final response = await orderRemoteDatasource.sendOrder(orderRequest);
        if (response) {
          await OrderLocalDatasource.instance.updateIsSyncOrderById(order.id!);
        }
      }

      // emit(const SyncOrderState.success());
      final cekLagi = await OrderLocalDatasource.instance.getOrderByIsSync();
      if (cekLagi.isEmpty) {
        emit(const SyncOrderState.success());
      } else {
        emit(const SyncOrderState.error('Failed to send order'));
      }
    });
  }
}
