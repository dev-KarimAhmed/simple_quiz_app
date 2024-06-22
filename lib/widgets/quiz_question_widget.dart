import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

class QuizQuestionWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<int> onAnswerSelected;
  final int? selectedAnswer;
  final int questionNumber, questionsCount;
  final List<int?> selectedAnswers;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.selectedAnswer,
    required this.questionNumber,
    required this.questionsCount,
    required this.selectedAnswers,
  });

  Widget _buildHorizontalStepper(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: List.generate(questionsCount, (index) {
              bool isActive = selectedAnswers[index] != null;
              return SizedBox(
                height: 40,
                width: 60,
                child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  isFirst: index == 0,
                  isLast: index == questionsCount - 1,
                  beforeLineStyle: LineStyle(
                    color: isActive ? Colors.green : Colors.grey,
                    thickness: 4,
                  ),
                  afterLineStyle: LineStyle(
                    color: isActive ? Colors.green : Colors.grey,
                    thickness: 4,
                  ),
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 40,
                    indicator: CircleAvatar(
                      radius: 16,
                      backgroundColor: isActive ? Colors.green : Colors.grey,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  endChild: Container(
                    alignment: Alignment.center,
                    child: isActive
                        ? Text(
                            'Question ${index + 1}',
                            style: TextStyle(color: Colors.green),
                          )
                        : null,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHorizontalStepper(context),
          const SizedBox(height: 20),
          Text(
            question.text,
            style: const TextStyle(fontSize: 24),
          ),
          question.imageUrl != null
              ? Image.network(question.imageUrl!)
              : Container(),
          const SizedBox(height: 20),
          ...List.generate(question.answers.length, (index) {
            bool isSelected = selectedAnswer == index;
            return GestureDetector(
              onTap: () {
                onAnswerSelected(index);
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  question.answers[index].text,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
