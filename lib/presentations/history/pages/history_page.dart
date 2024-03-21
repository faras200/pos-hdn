import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/history/widgets/transction_detail_dialoge.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(const HistoryEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History Orders',
            style: TextStyle(fontWeight: FontWeight.bold)),
        // backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<HistoryBloc, HistoryState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              successDelete: (success) {
                if (success) {
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
                    btnOkOnPress: () {
                      debugPrint('OnClcik');
                    },
                    btnOkIcon: Icons.check_circle,
                  ).show();
                }
              });
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
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  itemCount: datas.length,
                  separatorBuilder: (context, index) => const SpaceHeight(8.0),
                  itemBuilder: (context, index) {
                    final data = datas[index];
                    selectedItem[index] = selectedItem[index] ?? false;
                    bool? isSelectedData = selectedItem[index];
                    return Container(
                      margin: paddingHorizontal,
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
                  });
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
