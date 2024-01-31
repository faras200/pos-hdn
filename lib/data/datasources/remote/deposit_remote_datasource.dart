import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/datasources/local/auth_local_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/result_response_api.dart';
import 'package:pos_hdn/data/models/response/auth_response_model.dart';
import 'package:pos_hdn/data/models/response/qris_dbs_response.dart';

class DepositRemoteDatasource {
  Future<Result<QrisDbsResponseModel, Exception>> storeDeposit(
      String orderId, int grossAmount) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': generateBasicAuthHeader('Mid-server-Yourkey'),
    };

    final body = jsonEncode({
      'uuid': orderId,
      'total': grossAmount,
    });
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/create/qr'),
        headers: headers,
        body: body,
      );
      switch (response.statusCode) {
        case 200:
          // 2. return Success with the desired value
          return Success(QrisDbsResponseModel.fromJson(response.body));
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
