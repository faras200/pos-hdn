import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/auth_remote_datasource.dart';
import 'package:pos_hdn/data/models/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDataSource;
  LoginBloc(this.authRemoteDataSource) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const LoginState.loading());

      final response = await authRemoteDataSource.login(
        event.email,
        event.password,
      );

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
