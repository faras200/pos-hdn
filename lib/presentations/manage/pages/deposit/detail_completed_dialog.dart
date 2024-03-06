import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/components/buttons.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/date_time_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/data/dataoutputs/detail_setoran_print.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/models/deposit_model.dart';
import 'package:pos_hdn/presentations/manage/pages/printer/manage_printer_page.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCompletedDialog extends StatefulWidget {
  final List<DetailDepositModel> dataDetail;
  final int amount;
  final String time;
  final String uuid;
  const DetailCompletedDialog(
      {super.key,
      required this.dataDetail,
      required this.amount,
      required this.uuid,
      required this.time});
  @override
  State<DetailCompletedDialog> createState() => _DetailCompletedDialogState();
}

class _DetailCompletedDialogState extends State<DetailCompletedDialog> {
  late String? macName = '';
  late SharedPreferences prefs;
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
    DateTime dateTime = DateTime.parse(widget.time);

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      scrollable: true,
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpaceHeight(24.0),
          Text(
            'DETAIL SETORAN',
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
            value: widget.amount.currencyFormatRp,
          ),
          const SpaceHeight(20.0),
          _LabelValue(
            label: 'WAKTU SETOR',
            value: dateTime.toFormattedTime(),
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
                    final data = widget.dataDetail[index];
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
                          data.uuid!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // subtitle: Text('${data.totalQuantity} items'),
                        trailing: Text(
                          data.amount!.currencyFormat,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.dataDetail.length,
                ),
              ),
              const SpaceHeight(30.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Button.filled(
                      color: AppColors.primary,
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
                        final printValue =
                            await DetailSetoranPrint.instance.printDetail(
                          widget.dataDetail,
                          widget.amount,
                          widget.uuid,
                          'QRIS',
                          widget.time,
                        );
                        await PrintBluetoothThermal.writeBytes(printValue);
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
