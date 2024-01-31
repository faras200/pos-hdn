part of 'qris_bloc.dart';

@freezed
class QrisState with _$QrisState {
  const factory QrisState.initial() = _Initial;
  const factory QrisState.loading() = _Loading;
  //qrisResponse
  const factory QrisState.qrisResponse(
      QrisDbsResponseModel qrisDbsResponseModel) = _QrisResponse;
  //qrisResponseDeposit
  const factory QrisState.qrisResponseDeposit(
      QrisResponseModel qrisResponseModel) = _QrisResponseDeposit;
  //success
  const factory QrisState.success(String message) = _Success;
  //error
  const factory QrisState.error(String message) = _Error;
  //status check
  const factory QrisState.statusCheck(
      QrisDbsStatusResponseModel qrisDbsStatusResponseModel) = _StatusCheck;
}
