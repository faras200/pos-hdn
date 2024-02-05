import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/datasources/local/auth_local_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/result_response_api.dart';
import 'package:pos_hdn/data/models/request/deposit_request_model.dart';
import 'package:pos_hdn/data/models/response/deposit_response_model.dart';
import 'package:pos_hdn/data/models/response/auth_response_model.dart';
import 'package:pos_hdn/data/models/response/qris_dbs_response.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

class DepositRemoteDatasource {
  DepositRemoteDatasource._init();
  static final DepositRemoteDatasource instance =
      DepositRemoteDatasource._init();

  Future<bool> storeDeposit(DepositRequestModel requestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.data.token}',
    };

    final body = requestModel.toJson();

    Logger().d(body);
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/pos/deposits/store'),
        headers: headers,
        body: body,
      );
      switch (response.statusCode) {
        case 200:
          // 2. return Success with the desired value
          return true;
        default:
          // 3. return Failure with the desired exception
          return false;
      }
    } on Exception catch (e) {
      // 4. return Failure here too
      return false;
    }
  }

  Future<Result<DepositResponseModel, Exception>> fetchRemoteDeposit() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.data.token}',
    };

    try {
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/pos/deposits/'),
        headers: headers,
      );
      switch (response.statusCode) {
        case 200:
          // 2. return Success with the desired value
          return Success(DepositResponseModel.fromJson(response.body));
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
