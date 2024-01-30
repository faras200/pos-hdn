part of 'setoran_bloc.dart';

@freezed
class SetoranState with _$SetoranState {
  const factory SetoranState.initial() = _Initial;
  const factory SetoranState.loading() = _Loading;
  const factory SetoranState.success(List<OrderModel> setoran) = _Success;
  const factory SetoranState.error(String message) = _Error;
}
