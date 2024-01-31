import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

part 'setoran_event.dart';
part 'setoran_state.dart';
part 'setoran_bloc.freezed.dart';

class SetoranBloc extends Bloc<SetoranEvent, SetoranState> {
  SetoranBloc() : super(const _Initial()) {
    on<SetoranEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_Fetch>((event, emit) async {
      emit(const SetoranState.loading());
      final data = await OrderLocalDatasource.instance.getOrderTunai();
      emit(SetoranState.success(data));
    });
  }
}
