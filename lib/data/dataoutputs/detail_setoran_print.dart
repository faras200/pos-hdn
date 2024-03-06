import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import 'package:intl/intl.dart';
import 'package:pos_hdn/core/extensions/date_time_ext.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/home/models/order_item.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/models/deposit_model.dart';

class DetailSetoranPrint {
  DetailSetoranPrint._init();

  static final DetailSetoranPrint instance = DetailSetoranPrint._init();

  Future<List<int>> printDetail(
    List<DetailDepositModel> products,
    int totalPrice,
    String uuid,
    String paymentMethod,
    String transactionTime,
  ) async {
    List<int> bytes = [];
    var outputDate = transactionTime;

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.reset();
    bytes += generator.text('Hoki Distribusi Niaga',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));

    bytes += generator.text(
        'Jl. Peta Barat No.9a, Kec. Kalideres, Kota Jakarta Barat 11830',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.hr();

    bytes += generator.row(
      [
        PosColumn(
          text: 'Date:',
          width: 3,
          styles: const PosStyles(align: PosAlign.left, underline: true),
        ),
        PosColumn(
          text: outputDate,
          width: 9,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ],
    );

    bytes += generator.row(
      [
        PosColumn(
          text: 'Receipt:',
          width: 4,
          styles: const PosStyles(align: PosAlign.left, underline: true),
        ),
        PosColumn(
          text: uuid,
          width: 8,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ],
    );

    bytes += generator.hr();
    bytes += generator.text('Invoice Setoran:',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    //for from data
    final lastProduct = products.last;
    for (final product in products) {
      // bytes += generator.text(product.product.name,
      //     maxCharsPerLine: 25, styles: const PosStyles(align: PosAlign.left));

      bytes += generator.row(
        [
          PosColumn(
            text: product.uuid!,
            width: 10,
            styles: const PosStyles(align: PosAlign.left, underline: true),
          ),
          PosColumn(
            // text: product.amount!.currencyFormat,
            text: '',
            width: 2,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ],
      );
      double totalSatuan = 0;
      for (final detail in product.detail!) {
        totalSatuan = (int.parse(detail.total!) / int.parse(detail.qty!));
        bytes += generator.row(
          [
            PosColumn(
              text: detail.produk == null ? '' : detail.produk!,
              width: 10,
              styles: const PosStyles(align: PosAlign.left, underline: true),
            ),
            PosColumn(
              text: '',
              width: 2,
              styles: const PosStyles(align: PosAlign.right),
            ),
          ],
        );

        bytes += generator.row([
          PosColumn(
            text: '${detail.qty} x  @${totalSatuan.toInt().currencyFormat}',
            width: 8,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: int.parse(detail.total!).currencyFormat,
            width: 4,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      if (product != lastProduct) {
        bytes += generator.feed(1);
      }
    }

    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
        text: 'Total Setoran',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: totalPrice.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.hr();

    bytes += generator.text('Terima kasih',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(3);

    return bytes;
  }
}
