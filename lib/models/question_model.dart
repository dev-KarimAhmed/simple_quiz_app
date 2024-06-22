import 'package:quiz_app/models/answer_model.dart';

class Question {
  final String text;
  final List<Answer> answers;
  final String? reasonOfCorrectAnswer;
  final String? imageUrl;

  Question({
    required this.text,
    required this.answers,
    this.imageUrl,
    this.reasonOfCorrectAnswer,
  });
}

//Questions [gotten from Api Response]

final List<Question> quizQuestions = [
  Question(
    text: 'What is the capital of France?',
    reasonOfCorrectAnswer: 'Paris is the capital of France',
    answers: [
      Answer(text: 'Berlin', isCorrect: false),
      Answer(text: 'Madrid', isCorrect: false),
      Answer(
        text: 'Paris',
        isCorrect: true,
      ),
      Answer(text: 'Lisbon', isCorrect: false),
    ],
  ),
  Question(
    text: 'Who painted the Mona Lisa?',
    imageUrl:
        'https://img.freepik.com/premium-photo/hd-poster-wallpaper-background-banner-creative-design-exquisite-business-poster-works_1025830-78767.jpg?w=826',
    answers: [
      Answer(text: 'Vincent Van Gogh', isCorrect: false),
      Answer(text: 'Leonardo Da Vinci', isCorrect: true),
      Answer(text: 'Pablo Picasso', isCorrect: false),
      Answer(text: 'Claude Monet', isCorrect: false),
    ],
  ),
  // Add more questions here

  Question(
    text: 'What is the largest planet in our solar system?',
    answers: [
      Answer(text: 'Jupiter', isCorrect: true),
      Answer(text: 'Saturn', isCorrect: false),
      Answer(text: 'Uranus', isCorrect: false),
      Answer(text: 'Neptune', isCorrect: false),
    ],
  ),
  Question(
    text: 'Who wrote the novel "To Kill a Mockingbird"?',
    answers: [
      Answer(text: 'Harper Lee', isCorrect: false),
      Answer(text: 'F. Scott Fitzgerald', isCorrect: false),
      Answer(text: 'George Orwell', isCorrect: true),
      Answer(text: 'Ernest Hemingway', isCorrect: false),
    ],
  ),
  Question(
    text: 'What is the smallest continent in the world?',
    answers: [
      Answer(text: 'Antarctica', isCorrect: true),
      Answer(text: 'Australia', isCorrect: false),
      Answer(text: 'Africa', isCorrect: false),
      Answer(text: 'Asia', isCorrect: false),
    ],
  ),
];
