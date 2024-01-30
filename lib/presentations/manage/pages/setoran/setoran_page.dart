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
  // ignore: non_constant_identifier_names
  List<Map> MyData = CustomData.mydata;
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  int totalPrice = 0;

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
              child: Text('No data oke'),
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
                    leading: _mainUI(isSelectedData!, data),
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

  Widget _mainUI(bool isSelected, OrderModel ourdata) {
    Logger().d(ourdata.toJson());
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
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
  }
}

class CustomData {
  static List<Map> mydata = [
    {
      "id": 1,
      "name": 'Tester1',
      "email": 'tester1@gamil.com',
      "address": 'Delhi'
    },
    {
      "id": 2,
      "name": 'Tester2',
      "email": 'tester2@gamil.com',
      "address": 'Noida'
    },
    {
      "id": 3,
      "name": 'Tester3',
      "email": 'tester3@gamil.com',
      "address": 'Kolkata'
    },
    {
      "id": 4,
      "name": 'Tester4',
      "email": 'tester4@gamil.com',
      "address": 'Goa'
    },
    {
      "id": 5,
      "name": 'Tester5',
      "email": 'tester5@gamil.com',
      "address": 'Mau'
    },
    {
      "id": 6,
      "name": 'Tester6',
      "email": 'tester6@gamil.com',
      "address": 'Bihar'
    },
    {
      "id": 7,
      "name": 'Tester7',
      "email": 'tester7@gamil.com',
      "address": 'Varanasi'
    },
    {
      "id": 8,
      "name": 'Tester8',
      "email": 'tester8@gamil.com',
      "address": 'GorakhPur'
    },
    {
      "id": 9,
      "name": 'Tester9',
      "email": 'tester9@gamil.com',
      "address": 'RameshNagar'
    },
    {
      "id": 10,
      "name": 'Tester10',
      "email": 'tester10@gamil.com',
      "address": 'Shakurpur'
    },
    {
      "id": 11,
      "name": 'Tester11',
      "email": 'tester11@gamil.com',
      "address": 'Patel Nagar'
    },
    {
      "id": 12,
      "name": 'Tester12',
      "email": 'tester12@gamil.com',
      "address": 'Mahuwari'
    },
    {
      "id": 13,
      "name": 'Tester13',
      "email": 'tester13@gamil.com',
      "address": 'Pali'
    },
    {
      "id": 14,
      "name": 'Tester14',
      "email": 'tester14@gamil.com',
      "address": 'Patana'
    },
    {
      "id": 15,
      "name": 'Tester15',
      "email": 'tester15@gamil.com',
      "address": 'Punjab'
    },
  ];
}
