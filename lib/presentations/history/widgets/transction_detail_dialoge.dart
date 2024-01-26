import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/components/buttons.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/date_time_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/data/dataoutputs/cwb_print.dart';
import 'package:pos_hdn/presentations/history/bloc/history_detail/history_detail_bloc.dart';
import 'package:pos_hdn/presentations/history/widgets/item_product_card.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';
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
          _LabelValue(
            label: 'TOTAL PEMBELIAN',
            value:
                '${dataDetail.totalPrice.currencyFormatRp}   ( ${dataDetail.paymentMethod} )',
          ),
          const Divider(height: 36.0),
          _LabelValue(
            label: 'NOMINAL BAYAR',
            value: dataDetail.nominalBayar.currencyFormatRp,
          ),
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
                            data: orders[index],
                          ),
                        ),
                      ),
                      const SpaceHeight(30.0),
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
                              icon: Assets.icons.print
                                  // ignore: deprecated_member_use_from_same_package
                                  .svg(color: AppColors.primary),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
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
