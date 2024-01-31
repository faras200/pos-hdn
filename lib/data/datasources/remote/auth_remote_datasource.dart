import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/data/datasources/local/auth_local_datasource.dart';
import 'package:pos_hdn/data/models/response/auth_response_model.dart';

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/login'), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/logout'), headers: {
      'Authorization': 'Bearer ${authData?.data.token}',
    });

    if (response.statusCode == 200) {
      return right(response.body);
    } else {
      return left(response.body);
    }
  }
}
