import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/history/widgets/transction_detail_dialoge.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatefulWidget {
  final OrderModel data;
  final int index;
  final EdgeInsetsGeometry? padding;
  final Function(bool) updateAvailebleData;
  final Function(bool) updateSelectItem;
  final bool isSelectItem;

  const HistoryTransactionCard({
    super.key,
    required this.data,
    required this.index,
    required this.updateAvailebleData,
    required this.updateSelectItem,
    required this.isSelectItem,
    this.padding,
  });

  @override
  State<HistoryTransactionCard> createState() => _HistoryTransactionCardState();
}

class _HistoryTransactionCardState extends State<HistoryTransactionCard> {
  Map<int, bool> selectedItem = {};
  List<OrderModel> selectedData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedItem[widget.index] = selectedItem[widget.index] ?? false;
    bool? isSelectedData = selectedItem[widget.index];
    return Container(
      margin: widget.padding,
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
        onLongPress: () {
          if (!widget.isSelectItem) {
            setState(() {
              selectedItem[widget.index] = !isSelectedData;
              widget.updateSelectItem(selectedItem.containsValue(true));
              // widget.isSelectItem = selectedItem.containsValue(true);
              // totalPrice += widget.data.totalPrice!;
              selectedData.add(widget.data);
            });
          }
        },
        onTap: () {
          if (widget.isSelectItem) {
            setState(() {
              selectedItem[widget.index] = !isSelectedData;
              Logger().d(selectedItem);
              widget.updateSelectItem(selectedItem.containsValue(true));
              // widget.isSelectItem = selectedItem.containsValue(true);
            });
          } else {
            showDialog(
              context: context,
              builder: (context) =>
                  TransactionDetailDialoge(dataDetail: widget.data),
            );
          }
        },
        leading: _mainUI(isSelectedData!),
        title: Text(widget.data.uuid!),
        subtitle: Text(
            '${widget.data.paymentMethod}, ${widget.data.totalQuantity} items'),
        trailing: Text(
          widget.data.totalPrice!.currencyFormatRp,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _mainUI(bool isSelected) {
    if (widget.isSelectItem) {
      return CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            isSelected ? Icons.check : Icons.check_box_outline_blank,
            color: AppColors.red,
          ));
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        // ignore: deprecated_member_use_from_same_package
        child: Assets.icons.payments.svg(color: AppColors.primary),
      );
    }
  }
}
