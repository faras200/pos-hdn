import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/order_remote_datasource.dart';
import 'package:pos_hdn/data/models/request/order_request_model.dart';
import 'package:pos_hdn/presentations/order/bloc/order/order_bloc.dart';
import 'package:pos_hdn/presentations/order/bloc/qris/qris_bloc.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';
import 'package:pos_hdn/presentations/order/widgets/payment_success_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class PaymentQrisDialog extends StatefulWidget {
  final int price;
  const PaymentQrisDialog({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  State<PaymentQrisDialog> createState() => _PaymentQrisDialogState();
}

class _PaymentQrisDialogState extends State<PaymentQrisDialog> {
  String orderId = '';
  Timer? timer;
  String qris = '';
  @override
  void initState() {
    orderId = 'INV${DateTime.now().millisecondsSinceEpoch}';
    context.read<QrisBloc>().add(QrisEvent.generateQRCode(
          orderId,
          100,
          // widget.price,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppColors.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Pembayaran QRIS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          const SpaceHeight(6.0),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, success: (data, qty, total, paymentMethod, nominal, idKasir,
                  namaKasir) {
                return Container(
                  width: context.deviceWidth,
                  padding: const EdgeInsets.all(14.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocListener<QrisBloc, QrisState>(
                        listener: (context, state) {
                          state.maybeWhen(orElse: () {
                            return;
                          }, qrisResponse: (data) {
                            const onSec = Duration(seconds: 3);
                            timer = Timer.periodic(onSec, (timer) {
                              context
                                  .read<QrisBloc>()
                                  .add(QrisEvent.checkPaymentStatus(
                                    orderId,
                                  ));
                            });
                          }, success: (message) async {
                            timer?.cancel();
                            final timeNow = DateFormat('yyyy-MM-ddTHH:mm:ss')
                                .format(DateTime.now());
                            final uuid = orderId;
                            final orderModel = OrderModel(
                                uuid: uuid,
                                qris: qris,
                                paymentMethod: paymentMethod,
                                nominalBayar: total,
                                orders: data,
                                totalQuantity: qty,
                                totalPrice: total,
                                idKasir: idKasir,
                                namaKasir: namaKasir,
                                transactionTime: timeNow,
                                isSync: false);

                            final saveDbLocal = await OrderLocalDatasource
                                .instance
                                .saveOrder(orderModel); //return id order

                            final orderItems = data
                                .map((e) => OrderItemModel(
                                    productId: e.product.id!,
                                    quantity: e.quantity,
                                    totalPrice: (e.quantity * e.product.harga)))
                                .toList();

                            final orderRequestModel = OrderRequestModel(
                                paymentMethod: paymentMethod,
                                transactionTime: timeNow,
                                kasirId: idKasir,
                                totalPrice: total,
                                totalItem: qty,
                                orderItems: orderItems,
                                uuid: uuid);

                            final saveDbRemote = await OrderRemoteDatasource
                                .instance
                                .sendOrder(orderRequestModel);

                            if (saveDbRemote) {
                              //Update db local to isSync
                              OrderLocalDatasource.instance
                                  .updateIsSyncOrderById(saveDbLocal);
                            }

                            // ignore: use_build_context_synchronously
                            context
                                .read<OrderBloc>()
                                .add(OrderEvent.addNominalBayar(
                                  total,
                                ));
                            // ignore: use_build_context_synchronously
                            context.pop();
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const PaymentSuccessDialog(),
                            );
                          });
                        },
                        child: BlocBuilder<QrisBloc, QrisState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return const SizedBox();
                              },
                              qrisResponse: (data) {
                                qris = data.qris!;
                                return Container(
                                  width: 256.0,
                                  height: 256.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 256.0,
                                      height: 256.0,
                                      child: QrImageView(
                                        data: '${data.qris}',
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              error: (message) => Container(
                                width: 256.0,
                                height: 256.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(message),
                                ),
                              ),
                              loading: () {
                                return Container(
                                  width: 256.0,
                                  height: 256.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SpaceHeight(5.0),
                      const Text(
                        'Scan QRIS untuk melakukan pembayaran',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
