import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question/models/question.dart';
import 'package:question/pages/addQuestion.dart';
import 'package:question/services/questionProvider.dart';

class QuestionsWidget extends StatelessWidget {
  const QuestionsWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Question> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      // horizontal).

      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Image.asset("assets/vvvv.jpg"),
        SizedBox(
          height: 70,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
              list[Provider.of<QuestionState>(context).index].questionText),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            SizedBox(
              width: 60,
            ),
            ElevatedButton(
                style: buttonStyles(),
                onPressed: () {
                  bool b = list[
                          Provider.of<QuestionState>(context, listen: false)
                              .index]
                      .isCorrect;
                  if (b) {
                    Provider.of<QuestionState>(context, listen: false)
                        .setReponse('votre reponse est correcte');
                  } else {
                    Provider.of<QuestionState>(context, listen: false)
                        .setReponse('votre reponse nest pas correct');
                  }
                },
                child: Text("vrai")),
            ElevatedButton(
                style: buttonStyles(),
                onPressed: () {
                  bool b = list[
                          Provider.of<QuestionState>(context, listen: false)
                              .index]
                      .isCorrect;
                  if (!b) {
                    Provider.of<QuestionState>(context, listen: false)
                        .setReponse('votre reponse est correcte');
                  } else {
                    Provider.of<QuestionState>(context, listen: false)
                        .setReponse('votre reponse nest pas correct');
                  }
                },
                child: Text("faux")),
            SizedBox(width: 20),
            ElevatedButton(
                style: buttonStyles(),
                onPressed: () {
                  Provider.of<QuestionState>(context, listen: false)
                      .next(list.length);
                  print(
                      Provider.of<QuestionState>(context, listen: false).index);
                },
                child: Text("Suivant")),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        Text(Provider.of<QuestionState>(context).reponse,
            style: TextStyle(color: Colors.white)),
        SizedBox(
          height: 80,
        ),
        ElevatedButton(
          style: buttonStyles(),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestion(length: list.length)),
            );
          },
          child: Text(
            "Ajouter une question",
          ),
        ),
      ],
    );
  }

  ButtonStyle buttonStyles() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.white;
          return Colors.amber; // Use the component's default.
        },
      ),
    );
  }
}
