import 'package:flutter/material.dart';
import 'package:pos_hdn/core/components/buttons.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/payment_dialog.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

class DetailDialog extends StatelessWidget {
  final List<OrderModel> dataDetail;
  final int amount;
  const DetailDialog(
      {super.key, required this.dataDetail, required this.amount});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      scrollable: true,
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpaceHeight(24.0),
          Text(
            'KONFIRMASI SETORAN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(20.0),
          _LabelValue(
            label: 'JUMLAH SETORAN',
            value: amount.currencyFormatRp,
          ),
          const Divider(height: 30.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DETAIL SETORAN',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SpaceHeight(5.0),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 250,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemBuilder: (builder, index) {
                    final data = dataDetail[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 48.0,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 0,
                            color: AppColors.black.withOpacity(0.06),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          data.uuid,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text('${data.totalQuantity} items'),
                        trailing: Text(
                          int.parse(data.totalPrice.toString()).currencyFormat,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: dataDetail.length,
                ),
              ),
              const SpaceHeight(30.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Button.filled(
                      color: AppColors.red,
                      onPressed: () {
                        context.pop();
                      },
                      label: 'Kembali',
                      fontSize: 13,
                    ),
                  ),
                  const SpaceWidth(10.0),
                  Flexible(
                    child: Button.filled(
                      onPressed: () {
                        context.pop();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => PaymentDialog(
                            price: amount,
                            data: dataDetail,
                          ),
                        );
                      },
                      label: 'Proses',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
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
