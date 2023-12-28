import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';

import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/pos/products'),
      headers: {
        'Authorization': 'Bearer ${authData?.data.token}',
      },
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
