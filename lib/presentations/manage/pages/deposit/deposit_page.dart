import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/manage/bloc/deposit/deposit_bloc.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/detail_completed_dialog.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/detail_dialog.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

// ignore: must_be_immutable
class DepositPage extends StatefulWidget {
  int selectedIndex;
  DepositPage({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  List<Widget> list = const [
    Tab(
      child: Text('Pending', style: TextStyle(color: AppColors.white)),
    ),
    Tab(
      child: Text(
        'Completed',
        style: TextStyle(color: AppColors.white),
      ),
    ),
  ];
  bool isSelectItem = false;
  bool isAvailebleData = false;
  Map<int, bool> selectedItem = {};
  int totalPrice = 0;
  List<OrderModel> dataSetoran = [];
  List<OrderModel> selectedData = [];
  @override
  void initState() {
    super.initState();

    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        widget.selectedIndex = _controller.index;
      });

      if (widget.selectedIndex == 0) {
        context.read<DepositBloc>().add(const DepositEvent.fetch());
      } else {
        context.read<DepositBloc>().add(const DepositEvent.fetchRemote());
      }
    });
    // Logger().d(widget.selectedIndex);
    if (widget.selectedIndex == 0) {
      _controller.animateTo(0);
      context.read<DepositBloc>().add(const DepositEvent.fetch());
    } else {
      _controller.animateTo(1);
      context.read<DepositBloc>().add(const DepositEvent.fetchRemote());
    }

    Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: list,
            controller: _controller,
          ),
          title: const Text(
            "Setoran",
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            BlocBuilder<DepositBloc, DepositState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }, success: (setoran) {
                  if (setoran.isEmpty) {
                    isAvailebleData = false;
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                  isAvailebleData = true;
                  dataSetoran = setoran;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    itemBuilder: (builder, index) {
                      final data = setoran[index];
                      selectedItem[index] = selectedItem[index] ?? false;
                      bool? isSelectedData = selectedItem[index];

                      return Container(
                        margin: EdgeInsets.only(
                            left: 15,
                            bottom: setoran.length - 1 == index ? 80 : 5,
                            right: 15,
                            top: 5),
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
                                totalPrice += data.totalPrice!;
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
                                totalPrice -= data.totalPrice!;
                                selectedData.remove(data);
                              } else {
                                totalPrice += data.totalPrice!;
                                selectedData.add(data);
                              }
                            } else {
                              // Open Detail Page
                            }
                          },
                          title: Text(data.uuid!,
                              style: const TextStyle(
                                fontSize: 14,
                              )),
                          subtitle: Text('${data.paymentMethod}'),
                          trailing: Text(
                            data.totalPrice!.currencyFormatRp,
                            style: const TextStyle(
                              color: AppColors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          leading: _mainUI(isSelectedData!),
                        ),
                      );
                    },
                    itemCount: setoran.length,
                  );
                });
              },
            ),
            BlocBuilder<DepositBloc, DepositState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }, remotesuccess: (deposits) {
                  if (deposits.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                  // dataSetoran = setoran;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    itemBuilder: (builder, index) {
                      final data = deposits[index];
                      return Container(
                        margin: EdgeInsets.only(
                            left: 15,
                            bottom: deposits.length - 1 == index ? 80 : 5,
                            right: 15,
                            top: 5),
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => DetailCompletedDialog(
                                dataDetail: deposits[index].orders!,
                                amount: data.amount!,
                                time: data.time!,
                              ),
                            );
                          },
                          title: Text(data.uuid!,
                              style: const TextStyle(
                                fontSize: 14,
                              )),
                          subtitle: Text('${data.orders!.length} orders'),
                          trailing: Text(
                            data.amount!.currencyFormatRp,
                            style: const TextStyle(
                              color: AppColors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            // ignore: deprecated_member_use_from_same_package
                            child: Assets.icons.done.svg(),
                          ),
                        ),
                      );
                    },
                    itemCount: deposits.length,
                  );
                });
              },
            ),
          ],
        ),
        floatingActionButton: isAvailebleData
            ? Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isSelectItem
                        ? FloatingActionButton.extended(
                            heroTag: "btn2",
                            backgroundColor: AppColors.primary,
                            label: Text(
                              'Proses Setoran ${totalPrice.currencyFormatRp}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            icon:
                                const Icon(Icons.payment, color: Colors.white),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => DetailDialog(
                                    dataDetail: selectedData,
                                    amount: totalPrice),
                              );
                            },
                          )
                        : const SizedBox(),
                    Expanded(child: Container()),
                    FloatingActionButton(
                      heroTag: "btn1",
                      child: const Icon(Icons.check),
                      onPressed: () {
                        selectAllAtOnceGo();
                      },
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _mainUI(bool isSelected) {
    if (isSelectItem) {
      return CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: AppColors.primary,
          ));
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        // ignore: deprecated_member_use_from_same_package
        child: Assets.icons.payments.svg(color: AppColors.primary),
      );
    }
  }

  selectAllAtOnceGo() {
    bool isFalseAvailable = selectedItem.containsValue(false);
    selectedItem.updateAll((key, value) => isFalseAvailable);
    totalPrice = 0;
    if (isFalseAvailable) {
      dataSetoran.forEach((data) {
        selectedData.add(data);
        totalPrice += data.totalPrice!;
      });
    } else {
      selectedData = [];
      totalPrice = 0;
    }
    // ignore: avoid_function_literals_in_foreach_calls
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
  }
}
