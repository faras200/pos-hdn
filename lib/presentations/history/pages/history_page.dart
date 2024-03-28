import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/history/widgets/transction_detail_dialoge.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';
import 'package:units_converter/units_converter.dart';

import '../../../core/components/spaces.dart';

import '../bloc/history/history_bloc.dart';

import '../widgets/history_transaction_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Map<int, bool> selectedItem = {};
  List<OrderModel> selectedData = [];
  bool isSelectItem = false;
  int totalAmount = 0;
  int totalDailymeal = 0;
  int totalTopikoki = 0;
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime.now();
  @override
  void initState() {
    super.initState();
    firstDayOfMonth = DateTime(now.year, now.month, 1);

    fromDate.text = DateFormat('yyyy-MM-dd').format(firstDayOfMonth).toString();

    toDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    context
        .read<HistoryBloc>()
        .add(HistoryEvent.fetchbydate(fromDate.text, toDate.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(199.0),
        child: Container(
          clipBehavior: Clip.none,
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              AppBar(
                title: const Text('History Orders',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.share),
                                title: Text('Share'),
                              ),
                              ListTile(
                                leading: Icon(Icons.copy),
                                title: Text('Copy Link'),
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    // ignore: deprecated_member_use_from_same_package
                    icon: const Icon(Icons.tune),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 5, bottom: 0, right: 10, left: 10),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 10, left: 10),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: fromDate,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today,
                                  size: 18), //icon of text field
                              labelText: "Dari Tanggal" //label text of field
                              ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(fromDate.text),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                fromDate.text =
                                    formattedDate; //set output date to TextField value.
                              });

                              // ignore: use_build_context_synchronously
                              context.read<HistoryBloc>().add(
                                  HistoryEvent.fetchbydate(
                                      fromDate.text, toDate.text));
                            } else {}
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: toDate,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                size: 18,
                              ), //icon of text field
                              labelText: "Sampai Tanggal" //label text of field
                              ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(toDate.text),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                toDate.text =
                                    formattedDate; //set output date to TextField value.
                              });

                              // ignore: use_build_context_synchronously
                              context.read<HistoryBloc>().add(
                                  HistoryEvent.fetchbydate(
                                      fromDate.text, toDate.text));
                            } else {}
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 10, left: 10),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 14, right: 10, left: 10),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Topikoki'),
                            Text(
                              totalTopikoki >= 1000
                                  ? '${totalTopikoki.convertFromTo(MASS.grams, MASS.kilograms)?.toInt()} Kg'
                                  : '0 Kg',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ]),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Amount'),
                            Text(totalAmount.currencyFormatRp,
                                style: const TextStyle(color: Colors.red))
                          ]),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Dailymeal'),
                            Text('${totalDailymeal.currencyFormat} Pcs',
                                style: const TextStyle(color: Colors.green))
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<HistoryBloc, HistoryState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: (histories) {
              if (histories.isNotEmpty) {
                setState(() {
                  totalAmount = histories.fold(
                      0,
                      (previousValue, element) =>
                          previousValue + element.totalPrice!);
                  totalDailymeal = histories.fold(
                    0,
                    (previousValue, element) =>
                        previousValue +
                        element.orders.fold(
                          0,
                          (previousValue1, element1) =>
                              previousValue1 +
                              (element1.product.typeId == 1
                                  ? element1.quantity
                                  : 0),
                        ),
                  );
                  totalTopikoki = histories.fold(
                    0,
                    (previousValue, element) =>
                        previousValue +
                        element.orders.fold(
                          0,
                          (previousValue1, element1) =>
                              previousValue1 +
                              (element1.product.typeId == 2
                                  ? (element1.quantity * element1.product.berat)
                                  : 0),
                        ),
                  );
                });
              } else {
                setState(() {
                  totalAmount = 0;
                  totalDailymeal = 0;
                  totalTopikoki = 0;
                });
              }
            },
            successDelete: (success) {
              if (success) {
                context
                    .read<HistoryBloc>()
                    .add(HistoryEvent.fetchbydate(fromDate.text, toDate.text));
                Logger().d(success);
                Logger().d('deleted');
                setState(() {
                  isSelectItem = false;
                  selectedItem = {};
                  selectedData = [];
                });

                AwesomeDialog(
                  context: context,
                  animType: AnimType.topSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.success,
                  showCloseIcon: true,
                  title: 'Success',
                  desc: 'Transaksi berhasil di hapus',
                  btnOkOnPress: () {},
                  btnOkIcon: Icons.check_circle,
                ).show();
              }
            },
          );
        },
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const Center(
                child: Text('No data'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, success: (datas) {
              // isSelectItem = false;
              if (datas.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              }
              return Container(
                margin: const EdgeInsets.only(top: 15),
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    itemCount: datas.length,
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(10.0),
                    itemBuilder: (context, index) {
                      final data = datas[index];
                      selectedItem[index] = selectedItem[index] ?? false;
                      bool? isSelectedData = selectedItem[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                            if (!isSelectItem) {
                              setState(() {
                                selectedItem[index] = !isSelectedData;
                                isSelectItem = selectedItem.containsValue(true);
                                // totalPrice += data.totalPrice!;
                                selectedData.add(data);
                              });
                            }
                          },
                          onTap: () {
                            if (isSelectItem) {
                              setState(() {
                                selectedItem[index] = !isSelectedData;
                                isSelectItem = selectedItem.containsValue(true);
                              });

                              if (isSelectedData) {
                                selectedData.remove(data);
                              } else {
                                selectedData.add(data);
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    TransactionDetailDialoge(dataDetail: data),
                              );
                            }
                          },
                          leading: _mainUI(isSelectedData!, data.isSync),
                          title: Text(data.uuid!),
                          subtitle: Text(
                              '${data.paymentMethod}, ${data.totalQuantity} items'),
                          trailing: Text(
                            data.totalPrice!.currencyFormatRp,
                            style: const TextStyle(
                              color: AppColors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }),
              );
            });
          },
        ),
      ),
      floatingActionButton: isSelectItem
          ? FloatingActionButton.extended(
              label: const Text(
                'Delete Selected',
                style: TextStyle(color: AppColors.white),
              ),
              icon: const Icon(Icons.delete, color: AppColors.white),
              backgroundColor: AppColors.red,
              onPressed: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: false,
                        animType: AnimType.bottomSlide,
                        title: 'Yakin Hapus Item?',
                        desc: 'Data yang tehapus tidak dapat dikembalikan!',
                        buttonsTextStyle: const TextStyle(color: Colors.white),
                        showCloseIcon: true,
                        btnCancelOnPress: () {},
                        btnCancelColor: AppColors.primary,
                        btnOkOnPress: () {
                          context
                              .read<HistoryBloc>()
                              .add(HistoryEvent.delete(selectedData));
                        },
                        btnOkColor: AppColors.red)
                    .show();
              },
            )
          : const SizedBox(),
    );
  }

  Widget _mainUI(bool isSelected, bool isSync) {
    if (isSelectItem) {
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
        child: Assets.icons.payments.svg(
          colorFilter: ColorFilter.mode(
            isSync ? AppColors.green : AppColors.disabled,
            BlendMode.srcIn,
          ),
        ),
      );
    }
  }
}
