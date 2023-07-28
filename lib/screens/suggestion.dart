import 'package:abel_proj_01/files/questions.dart';

class User {
  final String questionString;
  final String answerString;
  const User({required this.answerString, required this.questionString});
}

class MySuggestion {
  static final List<User> qAndA = List.generate(
      questionBank.length,
      (index) => User(
            questionString: questionBank[index].question,
            answerString: questionBank[index].answer,
          ));

  static List<User> getSuggestions(String query) {
    if (query == '') {
      return [];
    }

    return List.of(qAndA).where((question) {
      final questionLower = question.questionString.toLowerCase();
      final queryLower = query.toLowerCase();
      return questionLower.contains(queryLower);
    }).toList();
  }
}

class MySearchResult {
  static final List<User> qAndA2 = List.generate(
      questionBank.length,
      (index) => User(
            questionString: questionBank[index].question,
            answerString: questionBank[index].answer,
          ));

  static List<User> getSearchResult(String query) {
    final queryLower = query.toLowerCase();
    List serched = queryLower.split(' ');
    List<User> searchResult = [];
    int controller = serched.length;
    List<String> searchedWordJoin = [];
    for (int i = 0; i < serched.length; i++) {
      searchedWordJoin.add(serched.getRange(0, controller).join(' '));

      controller--;
    }

    for (int i = 0; i < searchedWordJoin.length; i++) {
      for (int j = 0; j < qAndA2.length; j++) {
        if (qAndA2[j]
            .questionString
            .toLowerCase()
            .contains(searchedWordJoin[i])) {
          if (!searchResult.contains(qAndA2[j])) {
            searchResult.add(qAndA2[j]);
          }
        }
      }
    }

    if (query == '') {
      return [];
    }

    return searchResult.toList();
  }
}



// static List<String> getQuestionSuggestion(String query) {
//     final List<String> questions = [];
//     for (int i = 0; i < questionBank.length; i++) {
//       questions.add(questionBank[i].question.toLowerCase());
//     }
//     return questions.where((question) {
//       final queryLower = query.toLowerCase();
//       return questions.contains(queryLower);
//     }).toList();
//   }