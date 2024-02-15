import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import 'package:intl/intl.dart';

class CwbPrint {
  CwbPrint._init();

  static final CwbPrint instance = CwbPrint._init();

  Future<List<int>> printQris(
    String qris,
  ) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.reset();
    // bytes += generator.text('Hoki Distribusi Niaga',
    //     styles: const PosStyles(
    //       bold: true,
    //       align: PosAlign.center,
    //       height: PosTextSize.size1,
    //       width: PosTextSize.size1,
    //     ));
    // bytes += generator.text(
    //     'Date : ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
    //     styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.hr();

    bytes += generator.qrcode(qris, size: QRSize.Size6);

    bytes += generator.hr();

    // bytes += generator.text('Terima kasih',
    //     styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(3);

    return bytes;
  }
}
