import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/datasources/local/auth_local_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/result_response_api.dart';
import 'package:pos_hdn/data/models/response/qris_dbs_response.dart';
import 'package:pos_hdn/data/models/response/qris_dbs_status_response.dart';
import 'package:http/http.dart' as http;
import 'package:pos_hdn/data/models/response/qris_response_model.dart';

class QrisDbsRemoteDatasource {
  String generateBasicAuthHeader(String serverKey) {
    final base64Credentials = base64Encode(utf8.encode('$serverKey:'));
    final authHeader = 'Basic $base64Credentials';

    return authHeader;
  }

  Future<Result<QrisDbsResponseModel, Exception>> generateQRCode(
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

  Future<Result<QrisResponseModel, Exception>> generateQRCodeDeposit(
      String orderId, int grossAmount) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': generateBasicAuthHeader('Mid-server-Yourkey'),
    };

    final body = jsonEncode({
      'uuid': orderId,
      'amount': grossAmount,
    });
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/dbs/qris'),
        headers: headers,
        body: body,
      );
      switch (response.statusCode) {
        case 200:
          // 2. return Success with the desired value
          return Success(QrisResponseModel.fromJson(response.body));
        default:
          // 3. return Failure with the desired exception
          return Failure(Exception(response.reasonPhrase));
      }
    } on Exception catch (e) {
      // 4. return Failure here too
      return Failure(e);
    }
  }

  Future<QrisDbsStatusResponseModel> checkPaymentStatus(String orderId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.data.token}',
    };

    final body = jsonEncode({
      'tgl': '',
      'uuid': orderId,
    });

    Logger().d(body);

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/dbs/status'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return QrisDbsStatusResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to check payment status');
    }
  }
}
