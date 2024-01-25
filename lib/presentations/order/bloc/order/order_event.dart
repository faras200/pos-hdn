part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
  const factory OrderEvent.addNominalBayar(int nominal) = _AddNominalBayar;
  const factory OrderEvent.processOrder(
      String paymentMethod, List<OrderItem> orders) = _ProcessOrder;
}
