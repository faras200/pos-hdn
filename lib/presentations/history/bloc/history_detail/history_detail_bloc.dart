import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:pos_hdn/data/datasources/local/product_local_datasource.dart';
import 'package:pos_hdn/data/models/request/order_request_model.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';
import 'package:pos_hdn/presentations/home/models/order_item.dart';

part 'history_detail_event.dart';
part 'history_detail_state.dart';
part 'history_detail_bloc.freezed.dart';

class HistoryDetailBloc extends Bloc<HistoryDetailEvent, HistoryDetailState> {
  HistoryDetailBloc() : super(const _Success([], [])) {
    on<_FetchDetail>((event, emit) async {
      emit(const HistoryDetailState.loading());
      final data = await OrderLocalDatasource.instance
          .getOrderItemByOrderIdLocal(event.idOrder);
      List<OrderItem> orderItems = [];

      for (var dataproduct in data) {
        final product = await ProductLocalDatasource.instance
            .getProductById(dataproduct.productId);

        orderItems.add(
            OrderItem(product: product.first, quantity: dataproduct.quantity));
      }

      emit(HistoryDetailState.success(data, orderItems));
    });
  }
}
