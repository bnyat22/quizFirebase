import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:question/main.dart';

import 'package:question/myWidgets/textBox.dart';
import 'package:question/models/question.dart';

// ignore: must_be_immutable
class AddQuestion extends StatefulWidget {
  AddQuestion({
    Key? key,
    required this.length,
  }) : super(key: key);
  int length;

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController? controller;

  String hintQuestion = "Veuillez mettre la question";

  String hintBool = "Veuillez écrire 'true' ou 'false' si elle vrai ou pas";

  final reference = FirebaseDatabase.instance.reference().child("questions");
  bool b = false;
  bool t = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter")),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.asset("assets/squid.png"),
            SizedBox(
              height: 50,
            ),
            Text(
              "Question",
              style: textStyles(),
            ),
            SizedBox(height: 10),
            Container(
                child: MyTextBox(
                    controller: controller, hintQuestion: hintQuestion)),
            SizedBox(height: 40),
            Text(
              "Vrai ou Faux?",
              style: textStyles(),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  "vrai",
                  style: textStyles(),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.white,
                  child: Checkbox(
                    value: b,
                    onChanged: (b) {
                      setState(() {
                        this.b = true;
                        this.t = false;
                      });
                    },
                    activeColor: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  "faux",
                  style: textStyles(),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.white,
                  child: Checkbox(
                    value: t,
                    onChanged: (b) {
                      setState(() {
                        this.b = false;
                        this.t = true;
                      });
                    },
                    activeColor: Colors.amber,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: buttonStyles(),
                onPressed: () {
                  Question q = Question(
                      questionText: controller!.text.trim(),
                      isCorrect: b ? true : false,
                      reponse: "reponse");
                  print(q.questionText);

                  int questionId = widget.length + 1;
                  reference.child(questionId.toString()).set(q.toJson());

                  widget.length++;
                  setState(() {
                    controller = new TextEditingController();
                    b = false;
                    t = false;
                  });
                },
                child: Text(
                  "Ajouter",
                  style: textStyles(),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: buttonStyles(),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: Text(
                  "Retourner",
                  style: textStyles(),
                )),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyles() => TextStyle(fontSize: 18);
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

  showResult() {}
}
