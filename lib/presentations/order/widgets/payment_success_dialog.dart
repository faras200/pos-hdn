import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/date_time_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:pos_hdn/data/dataoutputs/cwb_print.dart';
import 'package:pos_hdn/presentations/home/bloc/checkout/checkout_bloc.dart';
import 'package:pos_hdn/presentations/home/pages/dashboard_page.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/deposit_page.dart';
import 'package:pos_hdn/presentations/manage/pages/printer/manage_printer_page.dart';
import 'package:pos_hdn/presentations/order/bloc/order/order_bloc.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class PaymentSuccessDialog extends StatefulWidget {
  const PaymentSuccessDialog({super.key});

  @override
  State<PaymentSuccessDialog> createState() => _PaymentSuccessDialogState();
}

class _PaymentSuccessDialogState extends State<PaymentSuccessDialog> {
  late SharedPreferences prefs;
  late String? macName = '';

  Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    macName = prefs.getString("mac_print_name") ?? '';
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Assets.icons.done.svg()),
          const SpaceHeight(14.0),
          const Text(
            'Pembayaran berhasil',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            success: (data, qty, total, paymentType, nominal, idKasir,
                nameKasir, uuid) {
              context.read<CheckoutBloc>().add(const CheckoutEvent.started());
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceHeight(12.0),
                  _LabelValue(
                    label: 'NOMOR FAKTUR',
                    value: uuid,
                  ),
                  const Divider(height: 26.0),
                  _LabelValue(
                    label: 'METODE PEMBAYARAN',
                    value: paymentType,
                  ),
                  const Divider(height: 26.0),
                  _LabelValue(
                    label: 'TOTAL PEMBELIAN',
                    value: total.currencyFormatRp,
                  ),
                  const Divider(height: 26.0),
                  _LabelValue(
                    label: 'NOMINAL BAYAR',
                    value: nominal.currencyFormatRp,
                  ),
                  (nominal - total) > 0
                      ? const Divider(height: 26.0)
                      : const SizedBox.shrink(),
                  (nominal - total) > 0
                      ? _LabelValue(
                          label: 'Total Kembalian',
                          value: (nominal - total).currencyFormatRp,
                        )
                      : const SizedBox.shrink(),
                  const Divider(height: 26.0),
                  _LabelValue(
                    label: 'WAKTU TRANSAKSI',
                    value: DateTime.now().toFormattedTime(),
                  ),
                  const SpaceHeight(40.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Button.filled(
                          onPressed: () {
                            context
                                .read<OrderBloc>()
                                .add(const OrderEvent.started());
                            context.pushReplacement(const DashboardPage());
                          },
                          label: 'Selesai',
                          fontSize: 13,
                        ),
                      ),
                      const SpaceWidth(10.0),
                      Flexible(
                        child: Button.outlined(
                          onPressed: () async {
                            if (macName == '') {
                              setState(() {
                                macName = '0';
                              });
                              return AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      headerAnimationLoop: false,
                                      animType: AnimType.bottomSlide,
                                      title: 'Error!',
                                      desc: 'Printer tidak terdeteksi',
                                      buttonsTextStyle:
                                          const TextStyle(color: Colors.white),
                                      showCloseIcon: true,
                                      btnOkText: 'Setting Printer',
                                      btnOkOnPress: () {
                                        // context.pop();
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ManagePrinterPage()));
                                      },
                                      btnOkColor: AppColors.primary)
                                  .show();
                            }
                            final printValue = await CwbPrint.instance
                                .printOrder(
                                    data,
                                    qty,
                                    total,
                                    paymentType,
                                    nominal,
                                    nameKasir,
                                    uuid,
                                    DateFormat('yyyy-MM-ddTHH:mm:ss')
                                        .format(DateTime.now()));
                            await PrintBluetoothThermal.writeBytes(printValue);
                            // final result =
                            //     await PrintBluetoothThermal.writeBytes(ticket);
                          },
                          label: 'Print',
                          icon:
                              // ignore: deprecated_member_use_from_same_package
                              Assets.icons.print.svg(color: AppColors.primary),
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
