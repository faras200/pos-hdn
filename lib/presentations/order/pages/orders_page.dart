import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/presentations/home/bloc/checkout/checkout_bloc.dart';
import 'package:pos_hdn/presentations/home/models/order_item.dart';
import 'package:pos_hdn/presentations/order/bloc/order/order_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../models/order_model.dart';
import '../widgets/order_card.dart';
import '../widgets/payment_cash_dialog.dart';
import '../widgets/payment_qris_dialog.dart';
import '../widgets/process_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var indexValue = ValueNotifier(0);

  int totalPrice = 0;
  int cekItem = 0;
  List<OrderItem> orders = [];
  int calculateTotalPrice(List<OrderItem> orders) {
    return orders.fold(
        0,
        (previousValue, element) =>
            previousValue + element.product.harga * element.quantity);
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<CheckoutBloc>().add(const CheckoutEvent.started());
            },
            icon: Assets.icons.delete.svg(),
          ),
        ],
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(child: CircularProgressIndicator());
            },
            success: (data, qty, total) {
              cekItem = data.length;
              if (data.isEmpty) {
                indexValue = ValueNotifier(0);
                return const Center(child: Text('Belum ada order'));
              }
              totalPrice = total;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const SpaceHeight(20.0),
                itemBuilder: (context, index) => OrderCard(
                  padding: paddingHorizontal,
                  data: data[index],
                  onDeleteTap: () {
                    // orders.removeAt(index);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const SizedBox.shrink();
                  },
                  success: (data, qty, total) {
                    return ValueListenableBuilder(
                      valueListenable: indexValue,
                      builder: (context, value, _) => Row(
                        children: [
                          const SpaceWidth(10.0),
                          MenuButton(
                            iconPath: Assets.icons.cash.path,
                            label: 'Tunai',
                            isActive: value == 1,
                            onPressed: () {
                              if (cekItem != 0) {
                                indexValue.value = 1;
                                context.read<OrderBloc>().add(
                                    OrderEvent.addPaymentMethod('Tunai', data));
                              } else {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        headerAnimationLoop: false,
                                        animType: AnimType.bottomSlide,
                                        title: 'Peringatan!',
                                        desc: 'Produk tidak boleh kosong!!',
                                        buttonsTextStyle: const TextStyle(
                                            color: Colors.white),
                                        showCloseIcon: true,
                                        btnOkOnPress: () {},
                                        btnOkColor: AppColors.primary)
                                    .show();
                              }
                            },
                          ),
                          const SpaceWidth(10.0),
                          MenuButton(
                            iconPath: Assets.icons.qrCode.path,
                            label: 'QRIS',
                            isActive: value == 2,
                            onPressed: () {
                              if (cekItem != 0) {
                                indexValue.value = 2;
                                context.read<OrderBloc>().add(
                                    OrderEvent.addPaymentMethod('QRIS', data));
                              } else {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        headerAnimationLoop: false,
                                        animType: AnimType.bottomSlide,
                                        title: 'Peringatan!',
                                        desc: 'Produk tidak boleh kosong!!',
                                        buttonsTextStyle: const TextStyle(
                                            color: Colors.white),
                                        showCloseIcon: true,
                                        btnOkOnPress: () {},
                                        btnOkColor: AppColors.primary)
                                    .show();
                              }
                            },
                          ),
                          const SpaceWidth(10.0),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SpaceHeight(20.0),
            ProcessButton(
              price: 0,
              onPressed: () async {
                if (indexValue.value == 0) {
                  if (cekItem == 0) {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'Peringatan!',
                            desc: 'Produk tidak boleh kosong!!',
                            buttonsTextStyle:
                                const TextStyle(color: Colors.white),
                            showCloseIcon: true,
                            btnOkOnPress: () {},
                            btnOkColor: AppColors.primary)
                        .show();
                  } else {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'Peringatan!',
                            desc: 'Metode pembayaran wajib dipilih',
                            buttonsTextStyle:
                                const TextStyle(color: Colors.white),
                            showCloseIcon: true,
                            btnOkOnPress: () {},
                            btnOkColor: AppColors.primary)
                        .show();
                  }
                } else if (indexValue.value == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => PaymentCashDialog(
                      price: totalPrice,
                    ),
                  );
                } else if (indexValue.value == 2) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => PaymentQrisDialog(
                      price: totalPrice,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
