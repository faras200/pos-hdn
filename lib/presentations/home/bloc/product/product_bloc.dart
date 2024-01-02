import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/product_local_datasource.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';

import '../../../../data/datasources/product_remote_datasource.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  List<Product> products = [];
  ProductBloc(this._productRemoteDatasource) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());

      final response = await _productRemoteDatasource.getProducts();
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products = r.data;
          emit(ProductState.success(r.data));
        },
      );
    });

    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProduct = event.category == 0
          ? products
          : products
              .where((element) => element.typeId == event.category)
              .toList();

      emit(ProductState.success(newProduct));
    });

    on<_AddProduct>((event, emit) async {
      emit(const ProductState.loading());

      final newProducts =
          await ProductLocalDatasource.instance.insertProduct(event.product);
      products.add(newProducts);
      emit(ProductState.success(products));
    });
  }
}
