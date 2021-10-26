import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question/pages/addQuestion.dart';
import 'package:question/models/question.dart';
import 'package:question/services/questionProvider.dart';

class StartWidget extends StatelessWidget {
  const StartWidget({
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
              list[Provider.of<QuestionState>(context).index].questionText,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 120,
            child: ElevatedButton(
                style: buttonStyles(),
                onPressed: () {
                  Provider.of<QuestionState>(context, listen: false)
                      .next(list.length);
                },
                child: Text("Commencer")),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            width: 170,
            child: ElevatedButton(
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
          )
        ]);
  }

  ButtonStyle buttonStyles() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.black;
          return Colors.amber; // Use the component's default.
        },
      ),
    );
  }
}
