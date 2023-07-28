import 'package:abel_proj_01/files/materials/reusable_popup.dart';
import 'package:abel_proj_01/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../files/materials/constants.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({super.key, this.q, this.a});

  final String? q;
  final String? a;

  @override
  Widget build(BuildContext context) {
    return DisplayAnswer(q: q ?? '', a: a ?? '');
  }
}

class DisplayAnswer extends StatelessWidget {
  const DisplayAnswer({
    super.key,
    required this.q,
    required this.a,
  });

  final String q;
  final String a;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: const [ReusablePopUp()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Q:  ',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: SelectableText(
                    q,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 50,
              // indent: 10,
              thickness: 3.0,
            ),
            Row(
              children: [
                const Text(
                  'A:  ',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: SelectableText(
                    a,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: CircleAvatar(
                    backgroundColor:
                        Col(isDark: themeState.getDarkTheme).avaterBackground,
                    foregroundColor:
                        Col(isDark: themeState.getDarkTheme).iconsColor,
                    radius: 40,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 30,
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// SelectableText.rich(TextSpan(children: [
//                 const TextSpan(
//                   text: 'Q:',
//                   style: TextStyle(
//                     fontSize: 40,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 TextSpan(
//                   text: q,
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ])),