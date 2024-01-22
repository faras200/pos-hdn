import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/components/buttons.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/date_time_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/data/dataoutputs/cwb_print.dart';
import 'package:pos_hdn/data/datasources/product_local_datasource.dart';
import 'package:pos_hdn/presentations/history/bloc/history_detail/history_detail_bloc.dart';
import 'package:pos_hdn/presentations/history/widgets/item_product_card.dart';
import 'package:pos_hdn/presentations/home/bloc/checkout/checkout_bloc.dart';
import 'package:pos_hdn/presentations/home/models/order_item.dart';
import 'package:pos_hdn/presentations/home/pages/dashboard_page.dart';
import 'package:pos_hdn/presentations/order/bloc/order/order_bloc.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';
import 'package:pos_hdn/presentations/order/widgets/order_card.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class TransactionDetailDialoge extends StatelessWidget {
  final OrderModel dataDetail;
  const TransactionDetailDialoge({
    super.key,
    required this.dataDetail,
  });

  @override
  Widget build(BuildContext context) {
    DateTime parseDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dataDetail.transactionTime);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = inputDate.toFormattedTime();

    return AlertDialog(
      scrollable: true,
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpaceHeight(24.0),
          Text(
            'Detail Order',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(12.0),
          _LabelValue(
            label: 'METODE PEMBAYARAN',
            value: dataDetail.paymentMethod,
          ),
          const Divider(height: 30.0),
          _LabelValue(
            label: 'TOTAL PEMBELIAN',
            value: dataDetail.nominalBayar.currencyFormatRp,
          ),
          // const Divider(height: 36.0),
          // _LabelValue(
          //   label: 'NOMINAL BAYAR',
          //   value: 123000.currencyFormatRp,
          // ),
          const Divider(height: 30.0),
          _LabelValue(
            label: 'WAKTU PEMBAYARAN',
            value: outputDate,
          ),
          const SpaceHeight(30.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DETAIL ITEM PEMBELIAN',
                style: TextStyle(),
              ),
              SpaceHeight(5.0),
            ],
          ),
          BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                success: (data, product, orders) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          itemCount: product.length,
                          separatorBuilder: (context, index) =>
                              const SpaceHeight(10.0),
                          itemBuilder: (context, index) => ItemProductCard(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            data: product[index],
                          ),
                        ),
                      ),
                      const SpaceHeight(40.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Button.filled(
                              onPressed: () {
                                context.pop();
                              },
                              label: 'Kembali',
                              fontSize: 13,
                            ),
                          ),
                          const SpaceWidth(10.0),
                          Flexible(
                            child: Button.outlined(
                              onPressed: () async {
                                final printValue =
                                    await CwbPrint.instance.printOrder(
                                  orders,
                                  dataDetail.totalQuantity,
                                  dataDetail.totalPrice,
                                  dataDetail.paymentMethod,
                                  dataDetail.nominalBayar,
                                  dataDetail.namaKasir,
                                );
                                await PrintBluetoothThermal.writeBytes(
                                    printValue);
                              },
                              label: 'Print',
                              icon: Assets.icons.print.svg(),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                  // return Column(
                  //   children: [
                  //     SizedBox(
                  //       width: double.maxFinite,
                  //       height: 200,
                  //       child: ListView.builder(
                  //         itemBuilder: (context, index) {
                  //           return ListTile(
                  //             title: Text('${data[index].productId}'),
                  //             subtitle: Text(
                  //               product[index].name,
                  //             ),
                  //           );
                  //         },
                  //         itemCount: data.length,
                  //       ),
                  //     ),
                  //   ],
                  // );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(),
        ),
        const SpaceHeight(5.0),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
