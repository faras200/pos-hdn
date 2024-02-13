import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/components/buttons.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/data/dataoutputs/qris_print.dart';
import 'package:pos_hdn/data/datasources/local/order_local_datasource.dart';
import 'package:pos_hdn/data/datasources/remote/deposit_remote_datasource.dart';
import 'package:pos_hdn/data/models/request/deposit_request_model.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/payment_deposit_success_dialog.dart';
import 'package:pos_hdn/presentations/manage/pages/printer/manage_printer_page.dart';
import 'package:pos_hdn/presentations/order/bloc/qris/qris_bloc.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentDialog extends StatefulWidget {
  final int price;
  final List<OrderModel> data;
  const PaymentDialog({
    Key? key,
    required this.price,
    required this.data,
  }) : super(key: key);
  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  String orderId = 'DPS${DateTime.now().millisecondsSinceEpoch}';
  Timer? timer;
  String qris = '';
  String qris_id = '';

  late SharedPreferences prefs;
  late String? macName = '';

  Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    macName = prefs.getString("mac_print_name") ?? '';
  }

  @override
  void initState() {
    context.read<QrisBloc>().add(QrisEvent.generateQRCodeDeposit(
          orderId,
          100,
          // widget.price,
        ));
    loadPreferences();
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
          Container(
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
                    }, qrisResponseDeposit: (data) {
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
                      context.pop();
                      EasyLoading.instance
                        ..displayDuration = const Duration(milliseconds: 2000)
                        ..indicatorType = EasyLoadingIndicatorType.threeBounce
                        ..loadingStyle = EasyLoadingStyle.custom
                        ..indicatorSize = 40.0
                        ..radius = 10.0
                        ..backgroundColor = AppColors.primary
                        ..indicatorColor = AppColors.white
                        ..textColor = AppColors.white
                        ..maskType = EasyLoadingMaskType.black
                        ..userInteractions = false
                        ..dismissOnTap = false;
                      EasyLoading.show(status: 'loading...');
                      final uuid = orderId;

                      final depositRequestModel = DepositRequestModel(
                          qrisId: qris_id,
                          amount: widget.price,
                          orders: widget.data,
                          uuid: uuid);
                      final saveDbRemote = await DepositRemoteDatasource
                          .instance
                          .storeDeposit(depositRequestModel);

                      if (saveDbRemote) {
                        //Update db local to isSync
                        for (var depo in widget.data) {
                          await OrderLocalDatasource.instance
                              .updateIsDepositOrderById(depo.id!);
                        }
                      }
                      EasyLoading.dismiss();
                      // ignore: use_build_context_synchronously
                      context.pop();
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) =>
                            PaymentDepositSuccessDialog(amount: widget.price),
                      );
                    });
                  },
                  child: BlocBuilder<QrisBloc, QrisState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox();
                        },
                        qrisResponseDeposit: (data) {
                          qris = data.qris!;
                          qris_id = data.id.toString();
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
                                  data: qris,
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
                const SpaceHeight(10.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Button.filled(
                        onPressed: () {
                          timer?.cancel();
                          context.pop();
                        },
                        label: 'Batalkan',
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
                                      context.pop();
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
                          final printValue = await CwbPrint.instance.printQris(
                            qris,
                          );
                          await PrintBluetoothThermal.writeBytes(printValue);
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
            ),
          )
        ],
      ),
    );
  }
}
