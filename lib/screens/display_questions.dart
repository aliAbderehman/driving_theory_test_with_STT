import 'package:abel_proj_01/files/materials/constants.dart';
import 'package:abel_proj_01/files/materials/reusable_popup.dart';
import 'package:abel_proj_01/files/questions.dart';
import 'package:abel_proj_01/screens/answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class DisplayQuestions extends StatelessWidget {
  const DisplayQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(themeState.getDarkTheme
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              themeState.setDarkTheme = !themeState.getDarkTheme;
            },
          ),
          const ReusablePopUp()
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: questionBank.length,
            itemBuilder: (context, index) {
              return questionBox(
                themeState: themeState,
                index: index,
                questionText: questionBank[index].question,
                answerText: questionBank[index].answer,
              );
            }),
      ),
    );
  }
}

class questionBox extends StatelessWidget {
  const questionBox(
      {super.key,
      required this.index,
      required this.questionText,
      this.themeState,
      required this.answerText});

  final int index;
  final String questionText;
  final String answerText;

  final themeState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnswerScreen(
                      q: questionText,
                      a: answerText,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Col(isDark: themeState.getDarkTheme).avaterBackground,
                    foregroundColor:
                        Col(isDark: themeState.getDarkTheme).iconsColor,
                    child: Text((index + 1).toString()),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(),
              Text(
                questionText,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
