import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/presentations/home/bloc/logout/logout_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences prefs;
  bool valuefinger = false;
  bool offlineMode = false;
  bool alwaysWakeup = false;
  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      offlineMode = prefs.getBool("offline_mode") ?? false;
      alwaysWakeup = prefs.getBool("allways_wakeup") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        backgroundColor: const Color(0xfff6f6f6),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Pengaturan Umum'),
              tiles: [
                SettingsTile.switchTile(
                  title: const Text('Always WakeUp'),
                  leading: const Icon(Icons.visibility),
                  initialValue: alwaysWakeup,
                  onToggle: (bool value) {
                    prefs.setBool("allways_wakeup", value);
                    setState(() {
                      alwaysWakeup = value;
                      Wakelock.toggle(enable: value);
                    });
                  },
                ),
                SettingsTile(
                  title: const Text('Language'),
                  description: Text('English'),
                  leading: const Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: const Text('Offline Mode'),
                  leading: const Icon(Icons.wifi_off),
                  initialValue: offlineMode,
                  onToggle: (bool value) {
                    prefs.setBool("offline_mode", value);
                    setState(() {
                      offlineMode = value;
                    });
                  },
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Pengaturan Akun'),
              tiles: [
                SettingsTile(
                  title: const Text('Logout'),
                  description: const Text('Logout from this account'),
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.red,
                  ),
                  onPressed: (BuildContext context) {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                ),
              ],
            ),
          ],
        ));
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
