part of 'deposit_bloc.dart';

@freezed
class DepositState with _$DepositState {
  const factory DepositState.initial() = _Initial;
  const factory DepositState.loading() = _Loading;
  const factory DepositState.success(List<OrderModel> deposit) = _Success;
  const factory DepositState.error(String message) = _Error;
}
