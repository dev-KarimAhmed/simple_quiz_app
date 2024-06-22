import 'package:flutter/material.dart';
import 'package:quiz_app/models/answer_model.dart';
import 'package:quiz_app/models/question_model.dart';

class ResultPage extends StatelessWidget {
  //List of indexes of Selected Answers
  final List<int?> selectedAnswers;

  const ResultPage({super.key, required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    //Count Correct Answers (intially no correct answers are selected by default so equals to 0)
    int correctAnswersCount = 0;
//List of indexes of Incorrect Answers
    List<int> incorrectAnswers = [];
    // Loop through all questions
    // Check if selected answer is correct
    // If it is correct increment correctAnswersCount
    // If it is incorrect add it to incorrectAnswers
    // quizQuestions.length is the number of questions (gotten from Api call)
    for (int i = 0; i < quizQuestions.length; i++) {
      // i is the index of each question
      if (selectedAnswers[i] ==
          quizQuestions[i].answers.indexWhere((answer) => answer.isCorrect)) {
        correctAnswersCount++;
      } else {
        incorrectAnswers.add(i);
      }
    }

    return Scaffold(
      //TODO: Add AppBar
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You got $correctAnswersCount out of ${quizQuestions.length} correct!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            if (incorrectAnswers.isNotEmpty) ...[
              const Text(
                'Mistakes:',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              ...incorrectAnswers.map((index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question: ${quizQuestions[index].text}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Your Answer: ${quizQuestions[index].answers[selectedAnswers[index]!].text}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      Text(
                        'Correct Answer: ${quizQuestions[index].answers.firstWhere(
                              (answer) => answer.isCorrect,
                              orElse: () => Answer(
                                  text: 'No correct answer', isCorrect: false),
                            ).text}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      quizQuestions[index].reasonOfCorrectAnswer != null
                          ? Text(
                              'reason: ${quizQuestions[index].reasonOfCorrectAnswer}',
                              style: const TextStyle(color: Colors.green),
                            )
                          : Container(),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
