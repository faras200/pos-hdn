part of 'setoran_bloc.dart';

@freezed
class SetoranEvent with _$SetoranEvent {
  const factory SetoranEvent.started() = _Started;
  const factory SetoranEvent.fetch() = _Fetch;
  const factory SetoranEvent.addSetoran(List<OrderModel> setoran) = _AddSetoran;
}
