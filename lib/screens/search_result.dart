import 'package:abel_proj_01/files/materials/reusable_popup.dart';
import 'package:abel_proj_01/screens/answer_screen.dart';
import 'package:abel_proj_01/screens/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    final List<User> searchResult =
        MySearchResult.getSearchResult(query).toList();

    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.arrow_back)),
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
      body: searchResult.isEmpty
          ? Center(child: Text('No result found'))
          : Scrollbar(
              child: ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    return questionBox(
                      themeState: themeState,
                      index: index,
                      questionText: searchResult[index].questionString,
                      answerText: searchResult[index].answerString,
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
              const SizedBox(
                height: 10,
              ),
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
