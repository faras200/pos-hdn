import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/models/deposit_model.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

part 'deposit_bloc.freezed.dart';
part 'deposit_event.dart';
part 'deposit_state.dart';

class DepositBloc extends Bloc<DepositEvent, DepositState> {
  DepositBloc() : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const DepositState.loading());
      final data = await OrderLocalDatasource.instance.getOrderTunai();
      emit(DepositState.success(data));
    });
  }
}
