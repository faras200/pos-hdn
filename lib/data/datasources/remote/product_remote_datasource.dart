import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/models/request/product_request_model.dart';
import 'package:pos_hdn/data/models/response/add_product_response_model.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';

import '../local/auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();

    try {
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
    } catch (err) {
      return left(err.toString());
    }
  }

  Future<Either<String, AddProductResponseModel>> addProducts(
      ProductRequestModel productRequestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData?.data.token}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/pos/products/store'));
    request.fields.addAll(productRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', productRequestModel.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
