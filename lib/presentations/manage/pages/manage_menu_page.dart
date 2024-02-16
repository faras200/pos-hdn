import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/presentations/manage/pages/product/manage_product_page.dart';
import 'package:pos_hdn/presentations/manage/pages/deposit/deposit_page.dart';
import 'package:pos_hdn/presentations/manage/pages/settings_page.dart';
import 'package:pos_hdn/presentations/manage/pages/sync_data_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../../../data/datasources/local/auth_local_datasource.dart';
import '../../auth/pages/login_page.dart';
import '../../home/bloc/logout/logout_bloc.dart';
import 'printer/manage_printer_page.dart';

class ManageMenuPage extends StatelessWidget {
  const ManageMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.manage_accounts,
              size: 25,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                MenuButton(
                  iconPath: Assets.icons.product.path,
                  label: 'Kelola Produk',
                  onPressed: () {
                    // context.push(const ManageProductPage());
                  },
                  isImage: false,
                  isMenu: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.icons.printer.path,
                  label: 'Kelola Printer',
                  onPressed: () {
                    context.push(const ManagePrinterPage());
                  }, //=> context.push(const ManagePrinterPage()),
                  isImage: false,
                  isMenu: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                MenuButton(
                  iconPath: Assets.icons.setoran.path,
                  label: 'Kelola Setoran',
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepositPage(
                                selectedIndex: 0,
                              ))),
                  isImage: false,
                  isMenu: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.icons.sync.path,
                  label: 'Kelola Sync Data',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SyncDataPage()));
                  }, //=> context.push(const ManagePrinterPage()),
                  isImage: false,
                  isMenu: true,
                ),
              ],
            ),
          ),
          const SpaceHeight(100),
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
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
