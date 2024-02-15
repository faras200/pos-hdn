import 'package:logger/logger.dart';
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/datasources/remote/result_response_api.dart';
import 'package:pos_hdn/data/models/request/order_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:pos_hdn/data/models/response/deposit_response_model.dart';
import 'package:pos_hdn/data/models/response/order_response_model.dart';

import '../local/auth_local_datasource.dart';

class OrderRemoteDatasource {
  OrderRemoteDatasource._init();
  static final OrderRemoteDatasource instance = OrderRemoteDatasource._init();
  Future<bool> sendOrder(OrderRequestModel requestModel) async {
    final url = Uri.parse('${Variables.baseUrl}/pos/transactions/store');
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData?.data.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final log = Logger();
    log.d(requestModel.toJson());
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: requestModel.toJson(),
      );

      // ignore: unnecessary_null_comparison
      if (response.statusCode == 201 || response != null) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<Result<OrderResponseModel, Exception>> fetchOrder(
      String status) async {
    final url = Uri.parse(
        '${Variables.baseUrl}/pos/transactions?type=tunai&status=$status');
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData?.data.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      switch (response.statusCode) {
        case 200:
          // 2. return Success with the desired value
          return Success(OrderResponseModel.fromJson(response.body));
        default:
          // 3. return Failure with the desired exception
          return Failure(Exception(response.reasonPhrase));
      }
    } on Exception catch (e) {
      // 4. return Failure here too
      return Failure(e);
    }
  }
}
