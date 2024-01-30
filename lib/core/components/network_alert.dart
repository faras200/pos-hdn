import 'package:flutter/material.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/core/controller/conectivity_controller.dart';

class ConnectionAlert extends StatefulWidget {
  const ConnectionAlert({super.key});
  @override
  State<ConnectionAlert> createState() => _ConnectionAlertState();
}

class _ConnectionAlertState extends State<ConnectionAlert> {
  ConnectivityController connectivityController = ConnectivityController();
  @override
  void initState() {
    connectivityController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: connectivityController.isConnected,
        builder: (context, value, child) {
          if (value) {
            return const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.wifi, size: 25, color: AppColors.white),
              ],
            );
          } else {
            return const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 25, color: AppColors.red),
              ],
            );
          }
        });
  }
}
