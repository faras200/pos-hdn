import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_hdn/data/datasources/qris_dbs_remote_datasource.dart';
import 'package:pos_hdn/data/models/response/qris_dbs_response.dart';
import 'package:pos_hdn/data/models/response/qris_dbs_status_response.dart';

part 'qris_event.dart';
part 'qris_state.dart';
part 'qris_bloc.freezed.dart';

class QrisBloc extends Bloc<QrisEvent, QrisState> {
  final QrisDbsRemoteDatasource qrisDbsRemoteDatasource;
  QrisBloc(
    this.qrisDbsRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GenerateQRCode>((event, emit) async {
      emit(const QrisState.loading());
      final response = await qrisDbsRemoteDatasource.generateQRCode(
          event.orderId, event.grossAmount);

      final value = switch (response) {
        Success(value: final result) => emit(QrisState.qrisResponse(result)),
        Failure(exception: final exception) => emit(
            QrisState.error('Something went wrong: $exception'),
          ),
      };
    });

    on<_CheckPaymentStatus>((event, emit) async {
      final response =
          await qrisDbsRemoteDatasource.checkPaymentStatus(event.orderId);

      if (response.data!.txnList?[0].statusCode == 8000) {
        emit(const QrisState.success('Pembayaran Berhasil'));
      }
    });
  }
}
