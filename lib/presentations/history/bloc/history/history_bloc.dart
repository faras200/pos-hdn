import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/remote/order_remote_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/result_response_api.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const HistoryState.loading());
      final data = await OrderLocalDatasource.instance.getAllOrder();
      emit(HistoryState.success(data));
    });

    on<_Delete>((event, emit) async {
      emit(const HistoryState.loading());
      final histories = event.histories;
      List<String> ids =
          histories.map<String>((item) => item.uuid as String).toList();
      Logger().d(ids);
      final deleteLocal =
          await OrderLocalDatasource.instance.deleteOrderById(ids);

      if (deleteLocal > 0) {
        final deleteRemote =
            await OrderRemoteDatasource.instance.deleteOrder(ids);
        final data = await OrderLocalDatasource.instance.getAllOrder();
        if (deleteRemote) {
          Logger().d('delete success');
          emit(const HistoryState.successDelete(true));
          emit(HistoryState.success(data));
        } else {
          emit(HistoryState.success(data));
          emit(const HistoryState.successDelete(true));
        }
      } else {
        final data = await OrderLocalDatasource.instance.getAllOrder();
        emit(HistoryState.success(data));
        emit(const HistoryState.successDelete(false));
      }
    });
  }
}
