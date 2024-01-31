import 'package:logger/logger.dart';
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/models/request/order_request_model.dart';
import 'package:http/http.dart' as http;

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
}
