part of 'deposit_bloc.dart';

@freezed
class DepositEvent with _$DepositEvent {
  const factory DepositEvent.started() = _Started;
  const factory DepositEvent.fetch() = _Fetch;
}
