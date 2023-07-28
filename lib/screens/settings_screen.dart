import 'package:abel_proj_01/provider/text_size_provider.dart';
import 'package:flutter/material.dart';
// import 'package:hajj_and_umra_03/provider/text_size_provider.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final textState = Provider.of<TextSizeProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          const SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 50,
              thickness: 2,
            ),
          ),
          SwitchListTile(
              activeColor: const Color.fromARGB(255, 203, 138, 17),
              title: const Text('Theme'),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              value: themeState.getDarkTheme,
              onChanged: (bool value) {
                themeState.setDarkTheme = value;
              }),
          SwitchListTile(
              activeColor: const Color.fromARGB(255, 203, 138, 17),
              title: const Text('Large fonts'),
              secondary: const Icon(Icons.format_size_rounded),
              value: textState.getTextSize,
              onChanged: (bool value) {
                textState.setTextSize = value;
              }),
        ],
      ),
    );
  }
}
