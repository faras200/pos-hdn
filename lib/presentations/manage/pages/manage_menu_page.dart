import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:pos_hdn/presentations/manage/pages/manage_product_page.dart';
import 'package:pos_hdn/presentations/manage/pages/save_server_key_page.dart';
import 'package:pos_hdn/presentations/manage/pages/sync_data_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../auth/pages/login_page.dart';
import '../../home/bloc/logout/logout_bloc.dart';
import 'manage_printer_page.dart';

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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
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
                  onPressed: () {
                    context.push(const ManagePrinterPage());
                  }, //=> context.push(const ManagePrinterPage()),
                  isImage: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.managePrinterx.path,
                  label: 'Kelola Setoran',
                  onPressed: () => context.push(const SaveServerKeyPage()),
                  isImage: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.images.syncCloud.path,
                  label: 'Kelola Sync Data',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SyncDataPage()));
                  }, //=> context.push(const ManagePrinterPage()),
                  isImage: true,
                ),
              ],
            ),
          ),
          const SpaceHeight(100),
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    maximumSize: const Size(200, 100),
                    fixedSize: const Size(180, 50)),
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w900),
                ), //color: AppColors.red),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
