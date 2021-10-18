import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question/pages/addQuestion.dart';
import 'package:question/pages/home.dart';
import 'package:question/models/question.dart';
import 'package:question/services/questionProvider.dart';

import 'myWidgets/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return ChangeNotifierProvider(
      create: (context) => QuestionState(index: 0),
      child: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget("Il y a une erreur en Firebase");
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MyHomePage(title: "Quiz");
            }
            return Loading();
          }),
    );
  }
}




