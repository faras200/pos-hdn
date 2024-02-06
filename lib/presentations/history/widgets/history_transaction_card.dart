import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/history/bloc/history_detail/history_detail_bloc.dart';
import 'package:pos_hdn/presentations/history/widgets/transction_detail_dialoge.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatelessWidget {
  final OrderModel data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({
    super.key,
    required this.data,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
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
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => TransactionDetailDialoge(dataDetail: data),
          );
        },
        leading: Assets.icons.payments.svg(
          colorFilter: ColorFilter.mode(
            data.isSync ? AppColors.green : AppColors.disabled,
            BlendMode.srcIn,
          ),
        ),
        title: Text(data.uuid),
        subtitle: Text('${data.paymentMethod}, ${data.totalQuantity} items'),
        trailing: Text(
          data.totalPrice.currencyFormatRp,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
