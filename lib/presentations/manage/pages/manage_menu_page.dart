import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/presentations/home/bloc/product/product_bloc.dart';
import 'package:pos_hdn/presentations/manage/pages/manage_product_page.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/product_local_datasource.dart';
import '../../auth/pages/login_page.dart';
import '../../home/bloc/logout/logout_bloc.dart';
import 'manage_printer_page.dart';

// class ManageMenuPage extends StatelessWidget {
//   const ManageMenuPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kelola'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Row(
//             children: [
//               MenuButton(
//                 iconPath: Assets.images.manageProduct.path,
//                 label: 'Kelola Produk',
//                 onPressed: () => context.push(const ManageProductPage()),
//                 isImage: true,
//               ),
//               const SpaceWidth(15.0),
//               MenuButton(
//                 iconPath: Assets.images.managePrinter.path,
//                 label: 'Kelola Printer',
//                 onPressed: () => context.push(const ManagePrinterPage()),
//                 isImage: true,
//               ),
//             ],
//           ),
//           const SpaceHeight(100.0),
//           BlocConsumer<ProductBloc, ProductState>(
//             listener: (context, state) {
//               state.maybeMap(
//                 orElse: () {},
//                 success: (_) async {
//                   await ProductLocalDatasource.instance.removeAllProducts();
//                   await ProductLocalDatasource.instance
//                       .insertAllProduct(_.products.toList());

//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       backgroundColor: AppColors.primary,
//                       content: Text('Data Synced Successfuly!')));
//                 },
//               );
//             },
//             builder: (context, state) {
//               return state.maybeWhen(
//                 orElse: () {
//                   return ElevatedButton(
//                       onPressed: () {
//                         context
//                             .read<ProductBloc>()
//                             .add(const ProductEvent.fetch());
//                       },
//                       child: const Text('Sync Data'));
//                 },
//                 loading: () {
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               );
//             },
//           ),
//           const Divider(),
//           BlocConsumer<LogoutBloc, LogoutState>(
//             listener: (context, state) {
//               state.maybeMap(
//                   orElse: () {},
//                   success: (_) {
//                     AuthLocalDatasource().removeAuthData();
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LoginPage()));
//                   });
//             },
//             builder: (context, state) {
//               return ElevatedButton(
//                 onPressed: () {
//                   context.read<LogoutBloc>().add(const LogoutEvent.logout());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.red,
//                 ),
//                 child: const Text(
//                   'Logout',
//                   style: TextStyle(
//                     color: AppColors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             },
//           ),
//           const Divider(),
//           FutureBuilder<List<OrderModel>>(
//               future: ProductLocalDatasource.instance.getOrderByIsSync(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(
//                               snapshot.data![index].paymentMethod.toString()),
//                         );
//                       },
//                       itemCount: snapshot.data!.length,
//                     ),
//                   );
//                 } else {
//                   return const SizedBox();
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }

class ManageMenuPage extends StatefulWidget {
  const ManageMenuPage({super.key});

  @override
  State<ManageMenuPage> createState() => _ManageMenuPageState();
}

class _ManageMenuPageState extends State<ManageMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.manageProduct.path,
                  label: 'Kelola Produk',
                  onPressed: () => context.push(const ManageProductPage()),
                  isImage: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.images.managePrinter.path,
                  label: 'Kelola Printer',
                  onPressed:
                      () {}, //=> context.push(const ManagePrinterPage()),
                  isImage: true,
                ),
              ],
            ),
            const SpaceHeight(60),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  success: (_) async {
                    // await ProductLocalDatasource.instance.removeAllProduct();
                    await ProductLocalDatasource.instance
                        .insertAllProduct(_.products.toList());
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: AppColors.primary,
                        content: Text(
                          'Sync data success',
                        )));
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return ElevatedButton(
                        onPressed: () {
                          context
                              .read<ProductBloc>()
                              .add(const ProductEvent.fetch());
                        },
                        child: const Text('Sync Data'));
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
            const Divider(),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    AuthLocalDatasource().removeAuthData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                );
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('Logout'),
                );
              },
            ),
            const Divider(),
            FutureBuilder<List<OrderModel>>(
                future: ProductLocalDatasource.instance.getOrderByIsSync(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                snapshot.data![index].paymentMethod.toString()),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        ));
  }
}
