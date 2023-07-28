import 'dart:io';

import 'package:abel_proj_01/files/materials/constants.dart';
import 'package:abel_proj_01/files/materials/reusable_popup.dart';
import 'package:abel_proj_01/screens/answer_screen.dart';
import 'package:abel_proj_01/screens/display_questions.dart';
import 'package:abel_proj_01/screens/search_result.dart';
import 'package:abel_proj_01/screens/suggestion.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../provider/dark_theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    // final textState = Provider.of<TextSizeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(''),
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
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController myController = TextEditingController();
  stt.SpeechToText? _speech;
  bool _isListening = false;
  double _confidence = 1.0;
  final SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();

  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocus = false;
    final themeState = Provider.of<DarkThemeProvider>(context);
    void _listen() async {
      setState(() {
        isFocus = true;
      });
      if (!_isListening) {
        bool available = await _speech!.initialize(
          onStatus: (val) {
            print('onStatus: $val');

            if (val == 'done') _isListening = false;
          },
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          setState(() {
            _isListening = true;
            // isFocus = true;
          });
          _speech!.listen(
            onResult: (val) => setState(() {
              // _text = val.recognizedWords;
              myController.text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
            }),
          );
        }
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundColor:
                  Col(isDark: themeState.getDarkTheme).avaterBackground,
              foregroundColor: Col(isDark: themeState.getDarkTheme).iconsColor,
              child: IconButton(
                icon: const Icon(Icons.list_rounded),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DisplayQuestions()))
                      .then((_) => () {
                            setState(() {
                              myController.text = '';
                              isFocus = false;
                              print(_.toString());
                            });
                          });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SuggestionBox(
                    suggestionsBoxController: _suggestionsBoxController,
                    themeState: themeState,
                    myController: myController,
                    isFocus: isFocus),
                if (!Platform.isWindows)
                  AvatarGlow(
                    animate: _isListening,
                    glowColor: Theme.of(context).primaryColor,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 10),
                    repeat: true,
                    endRadius: 75.0,
                    child: Listener(
                      onPointerDown: (details) {
                        isFocus = true;

                        _listen();
                      },
                      onPointerUp: (details) {
                        setState(() {
                          _suggestionsBoxController.open();
                        });
                        _isListening = false;
                        if (myController.text != '') {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             SearchResult(query: myController.text)));
                        }

                        _speech!.stop();
                      },
                      child: CircleAvatar(
                        backgroundColor: Col(isDark: themeState.getDarkTheme)
                            .avaterBackground,
                        foregroundColor:
                            Col(isDark: themeState.getDarkTheme).iconsColor,
                        radius: 40,
                        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SuggestionBox extends StatelessWidget {
  const SuggestionBox({
    super.key,
    required SuggestionsBoxController suggestionsBoxController,
    required this.themeState,
    required this.myController,
    required this.isFocus,
  }) : _suggestionsBoxController = suggestionsBoxController;

  final SuggestionsBoxController _suggestionsBoxController;
  final DarkThemeProvider themeState;
  final TextEditingController myController;
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<User?>(
      suggestionsBoxController: _suggestionsBoxController,
      layoutArchitecture: (items, controller) {
        return Container(
          decoration: BoxDecoration(
              color: Col(isDark: themeState.getDarkTheme).boxColor),
          height: 400,
          child: ListView(
            controller: controller,
            shrinkWrap: true,
            children: items.toList(),
          ),
        );
      },
      hideSuggestionsOnKeyboardHide: false,
      suggestionsBoxVerticalOffset: 2.0,
      textFieldConfiguration: TextFieldConfiguration(
        onSubmitted: (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchResult(query: myController.text)));
        },
        style: TextStyle(color: Col(isDark: themeState.getDarkTheme).textColor),
        controller: myController,
        autofocus: isFocus,
        decoration: InputDecoration(
          fillColor: Col(isDark: themeState.getDarkTheme).inputFillColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          suffix: IconButton(
              onPressed: () {
                myController.text = '';
              },
              color: Col(isDark: themeState.getDarkTheme).textColor,
              icon: const Icon(Icons.clear)),
          prefix: Icon(
            Icons.search,
            color: Col(isDark: themeState.getDarkTheme).textColor,
          ),
          hintStyle:
              TextStyle(color: Col(isDark: themeState.getDarkTheme).textColor),
          hintText: '  Search question',
        ),
      ),
      suggestionsCallback: MySearchResult.getSearchResult,
      itemBuilder: (context, User? suggestion) {
        final question = suggestion!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Col(isDark: themeState.getDarkTheme).listTileFillCol,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              textColor: Colors.black45,
              title: Text(
                question.questionString,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        myController.text = suggestion!.questionString;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnswerScreen(
                      q: suggestion.questionString,
                      a: suggestion.answerString,
                    )));
      },
    );
  }
}
