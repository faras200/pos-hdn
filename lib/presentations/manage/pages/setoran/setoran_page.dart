import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/assets/assets.gen.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/presentations/manage/bloc/setoran/setoran_bloc.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

class SetoranPage extends StatefulWidget {
  const SetoranPage({super.key});

  @override
  State<SetoranPage> createState() => _SetoranPageState();
}

class _SetoranPageState extends State<SetoranPage> {
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  int totalPrice = 0;
  List<OrderModel> dataSetoran = [];
  @override
  void initState() {
    super.initState();
    context.read<SetoranBloc>().add(const SetoranEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setoran",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SetoranBloc, SetoranState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const Center(
              child: Text('No data'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, success: (setoran) {
            if (setoran.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }
            dataSetoran = setoran;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              itemBuilder: (builder, index) {
                final data = setoran[index];
                selectedItem[index] = selectedItem[index] ?? false;
                bool? isSelectedData = selectedItem[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 5.0),
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
                      setState(() {
                        selectedItem[index] = !isSelectedData;
                        isSelectItem = selectedItem.containsValue(true);
                        totalPrice += data.totalPrice;
                      });
                    },
                    onTap: () {
                      if (isSelectItem) {
                        setState(() {
                          selectedItem[index] = !isSelectedData;
                          isSelectItem = selectedItem.containsValue(true);
                        });
                      } else {
                        // Open Detail Page
                      }
                      isSelectedData
                          ? totalPrice -= data.totalPrice
                          : totalPrice += data.totalPrice;
                    },
                    title: Text(data.uuid),
                    subtitle: Text(
                        '${data.paymentMethod}, ${data.totalQuantity} items'),
                    trailing: Text(
                      data.totalPrice.currencyFormatRp,
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
      floatingActionButton: Padding(
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.payment, color: Colors.white),
                    onPressed: () {},
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
      totalPrice = 0;
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
    // ignore: avoid_function_literals_in_foreach_calls
    dataSetoran.forEach((data) {
      totalPrice += data.totalPrice;
    });
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
  }
}
