import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/pages/result_page.dart';
import 'package:quiz_app/widgets/quiz_question_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<int?> _selectedAnswers = List.filled(quizQuestions.length, null);

  void _finishQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(selectedAnswers: _selectedAnswers),
      ),
    );
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You must choose an answer!')),
    );
  }

  void _onPageChanged(int index) {
    if (_selectedAnswers[_currentIndex] == null) {
      _pageController.jumpToPage(_currentIndex);
      log('You must choose an answer!');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _goToNextPage() {
    if (_selectedAnswers[_currentIndex] == null) {
      _showSnackbar();
      log('You must choose an answer!');
    } else if (_currentIndex == quizQuestions.length - 1) {
      _finishQuiz();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                if (index > _currentIndex) {
                  _onPageChanged(index);
                } else {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
              itemCount: quizQuestions.length,
              itemBuilder: (context, index) {
                return QuizQuestionWidget(
                  questionNumber: index + 1,
                  questionsCount: quizQuestions.length,
                  question: quizQuestions[index],
                  onAnswerSelected: (answerIndex) {
                    setState(() {
                      _selectedAnswers[index] = answerIndex;
                    });
                  },
                  selectedAnswer: _selectedAnswers[index],
                  selectedAnswers: _selectedAnswers,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex == 0 ? null : _goToPreviousPage,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed:_goToNextPage,
                  child: Text(_currentIndex == quizQuestions.length - 1
                      ? 'Finish'
                      : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
