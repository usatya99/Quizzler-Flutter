import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> shopkeeper = [];
  void getAnswerChecked(bool userGetAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(
      () {
        if (quizBrain.isFinshed() == true) {
          Alert(
                  context: context,
                  title: "FINISHED!",
                  desc: "You have completed the Quiz..!")
              .show();
          quizBrain.reset();
          shopkeeper = [];
        } else if (correctAnswer == userGetAnswer) {
          shopkeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          shopkeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.isValidQuestion();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizBrain.getQuestionText(),
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'True',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              getAnswerChecked(true);
            },
            color: Colors.green,
          ),
        ),
        SizedBox(
          height: 18.0,
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'False',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              getAnswerChecked(false);
            },
            color: Colors.red,
          ),
        ),
        Row(
          children: shopkeeper,
        ),
      ],
    );
  }
}
