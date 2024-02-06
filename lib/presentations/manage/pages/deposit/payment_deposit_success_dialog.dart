import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/core/extensions/date_time_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/deposit_page.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';

class PaymentDepositSuccessDialog extends StatelessWidget {
  final int amount;
  const PaymentDepositSuccessDialog({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Assets.icons.done.svg()),
            const SpaceHeight(24.0),
            const Text(
              'Pembayaran telah sukses dilakukan',
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
              label: 'NOMINAL BAYAR',
              value: amount.currencyFormatRp,
            ),
            const Divider(height: 36.0),
            _LabelValue(
              label: 'WAKTU PEMBAYARAN',
              value: DateTime.now().toFormattedTime(),
            ),
            const SpaceHeight(40.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Button.filled(
                    onPressed: () {
                      context.pop();
                      context.pushReplacement(DepositPage(
                        selectedIndex: 1,
                      ));
                    },
                    label: 'Selesai',
                    fontSize: 13,
                  ),
                ),
                const SpaceWidth(10.0),
              ],
            ),
          ],
        ));
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
