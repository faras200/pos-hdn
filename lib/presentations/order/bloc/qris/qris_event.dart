part of 'qris_bloc.dart';

@freezed
class QrisEvent with _$QrisEvent {
  const factory QrisEvent.started() = _Started;
  //generateQRCode
  const factory QrisEvent.generateQRCode(String orderId, int grossAmount) =
      _GenerateQRCode;

  //generateQRCodeSetoran
  const factory QrisEvent.generateQRCodeDeposit(
      String orderId, int grossAmount) = _GenerateQRCodeDeposit;

  //checkPaymentStatus
  const factory QrisEvent.checkPaymentStatus(String orderId) =
      _CheckPaymentStatus;
}
