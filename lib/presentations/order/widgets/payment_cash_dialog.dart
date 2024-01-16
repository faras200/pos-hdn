import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/core/extensions/string_ext.dart';
import 'package:pos_hdn/data/datasources/product_local_datasource.dart';
import 'package:pos_hdn/presentations/order/bloc/order/order_bloc.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import 'payment_success_dialog.dart';

class PaymentCashDialog extends StatefulWidget {
  final int price;
  const PaymentCashDialog({super.key, required this.price});

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  TextEditingController? priceController;

  @override
  void initState() {
    priceController = TextEditingController(text: '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Stack(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.highlight_off),
            color: AppColors.primary,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Pembayaran - Tunai',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(16.0),
          CustomTextField(
            controller: priceController!,
            label: 'Nominal Bayar',
            showLabel: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final int priceValue = value.toIntegerFromText;
              priceController!.text = priceValue.currencyFormatRp;
              priceController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: priceController!.text.length));
            },
          ),
          const SpaceHeight(16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button.filled(
                onPressed: () {
                  priceController?.text = (widget.price).currencyFormatRp;
                },
                color: AppColors.light,
                disabled: false,
                label: 'Uang Pas',
                textColor: AppColors.primary,
                fontSize: 13.0,
                width: 120.0,
                height: 50.0,
              ),
              const SpaceWidth(4.0),
              Flexible(
                child: Button.filled(
                  onPressed: () {
                    priceController?.text =
                        (priceController!.text.toIntegerFromText + 10000)
                            .currencyFormatRp;
                  },
                  color: AppColors.light,
                  disabled: false,
                  label: 10000.currencyFormatRp,
                  textColor: AppColors.primary,
                  fontSize: 13.0,
                  height: 50.0,
                ),
              ),
            ],
          ),
          const SpaceHeight(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button.filled(
                onPressed: () {
                  priceController?.text =
                      (priceController!.text.toIntegerFromText + 50000)
                          .currencyFormatRp;
                },
                color: AppColors.light,
                disabled: false,
                label: 50000.currencyFormatRp,
                textColor: AppColors.primary,
                fontSize: 13.0,
                width: 120.0,
                height: 50.0,
              ),
              const SpaceWidth(4.0),
              Flexible(
                child: Button.filled(
                  onPressed: () {
                    priceController?.text =
                        (priceController!.text.toIntegerFromText + 100000)
                            .currencyFormatRp;
                  },
                  color: AppColors.light,
                  disabled: false,
                  label: 100000.currencyFormatRp,
                  textColor: AppColors.primary,
                  fontSize: 13.0,
                  height: 50.0,
                ),
              ),
            ],
          ),
          const SpaceHeight(30.0),
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success:
                    (data, qty, total, payment, nominal, idKasir, namaKasir) {
                  final orderModel = OrderModel(
                      paymentMethod: payment,
                      nominalBayar: nominal,
                      orders: data,
                      totalQuantity: qty,
                      totalPrice: total,
                      idKasir: idKasir,
                      namaKasir: namaKasir,
                      transactionTime: DateFormat('yyyy-MM-ddTHH:mm:ss')
                          .format(DateTime.now()),
                      isSync: false);
                  ProductLocalDatasource.instance.saveOrder(orderModel);
                  context.pop();
                  showDialog(
                    context: context,
                    builder: (context) => const PaymentSuccessDialog(),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const SizedBox();
              }, success: (data, qty, total, payment, _, idKasir, namaKasir) {
                return Button.filled(
                  onPressed: () {
                    if (priceController!.text.toIntegerFromText < total) {
                      return AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Peringatan!',
                              desc: 'Nominal uang bayar kurang',
                              buttonsTextStyle:
                                  const TextStyle(color: Colors.white),
                              showCloseIcon: true,
                              btnOkOnPress: () {},
                              btnOkColor: AppColors.primary)
                          .show();
                    }
                    context.read<OrderBloc>().add(OrderEvent.addNominalBayar(
                          priceController!.text.toIntegerFromText,
                        ));
                  },
                  label: 'Proses',
                );
              }, error: (message) {
                return const SizedBox();
              });
            },
          ),
        ],
      ),
    );
  }
}
