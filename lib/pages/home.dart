import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:question/myWidgets/questionWidget.dart';
import 'package:question/myWidgets/startWidget.dart';
import 'package:question/models/question.dart';
import 'package:question/services/questionProvider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ref = FirebaseDatabase.instance.reference().child("questions");
  List<Question> list = List.empty(growable: true);
  var brightness = SchedulerBinding.instance!.window;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var brightness = SchedulerBinding.instance!.window.platformBrightness;

    bool isDark = Brightness.dark == brightness;
    Provider.of<QuestionState>(context, listen: false)
        .changeThemeBySettings(isDark);
  }

  @override
  Widget build(BuildContext context) {
    brightness.onPlatformBrightnessChanged = () {
      print("goraaa");
      var bright = brightness.platformBrightness;
      bool isDark = bright == Brightness.dark;
      Provider.of<QuestionState>(context, listen: false)
          .changeThemeBySettings(isDark);
    };
    Question question = new Question(
        questionText: "QuizApplication", isCorrect: true, reponse: "reponse");
    list.add(question);
    ref.onValue.listen((event) {
      print("dana");
      if (event.snapshot.exists) {
        print("lat");
        Map<String, dynamic> maps = Map.from(event.snapshot.value);

        maps.forEach((key, value) {
          Map<Object?, Object?> map = value;
          print("lando" + map["questionText"].toString());
          Question q = new Question(
              questionText: map["questionText"].toString(),
              isCorrect: map["isCorrect"].toString().toLowerCase() == 'true'
                  ? true
                  : false,
              reponse: map["réponse"].toString());
          list.add(q);
          print(list[1].questionText + " baaa");
        });
      }
    });

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        brightness: Brightness.light,
      ),
      themeMode: Provider.of<QuestionState>(context).isOn
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: ColorScheme(
              primary: Colors.amber,
              primaryVariant: Colors.amberAccent,
              secondary: Colors.black,
              secondaryVariant: Colors.white,
              surface: Colors.white,
              background: Colors.black,
              error: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
              onSurface: Colors.amber,
              onBackground: Colors.black,
              onError: Colors.red,
              brightness: Brightness.dark)),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Questions/Réponses"),
          actions: [
            Switch(
                value: Provider.of<QuestionState>(context, listen: false).isOn,
                onChanged: (val) {
                  Provider.of<QuestionState>(context, listen: false)
                      .changeTheme();
                  print("ll " +
                      Provider.of<QuestionState>(context, listen: false)
                          .isOn
                          .toString());
                }),
          ],
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Provider.of<QuestionState>(context).index == 0
              ? StartWidget(list: list)
              : QuestionsWidget(list: list),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
