import 'package:abel_proj_01/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'package:provider/provider.dart';

// import '../provider/dark_theme_provider.dart';

class MorphTxtDisplay extends StatelessWidget {
  const MorphTxtDisplay({super.key, required this.displayText});
  final Widget displayText;
  final isPressed = true;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    double blur = 2.0;
    Offset distance = const Offset(5, 5);
    return Container(
      // height: 120,
      // width: double.infinity,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          // image: decore ? Decoration: ,
          // image: const DecorationImage(
          // image: AssetImage('assets/images/halq_05.png'),
          // alignment: Alignment.centerLeft,
          // fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(15),
          color: themeState.getDarkTheme
              ? const Color(0xFF2E3239)
              : const Color(0xFFE7ECEF),
          // borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              offset: distance,
              color: themeState.getDarkTheme
                  ? const Color(0xFF23262a)
                  : const Color(0xFFA7A9AF),
              blurRadius: blur,
              inset: isPressed,
            ),
            BoxShadow(
              offset: -distance,
              color: themeState.getDarkTheme
                  ? const Color(0xFF35393F)
                  : const Color.fromARGB(255, 255, 255, 255),
              blurRadius: blur,
              inset: isPressed,
            ),
          ]),
      child: displayText,
    );
  }
}
