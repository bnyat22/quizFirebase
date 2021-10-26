import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class QuestionState extends ChangeNotifier {
  int index = 0;
  String reponse = "Reponse";
  QuestionState({required this.index});
  DatabaseReference firebase =
      FirebaseDatabase.instance.reference().child("questions");
  bool vrai = false, faux = false, added = false, isOn = false;
  String question = "r";

  void next(int length) {
    if (index < length - 1) {
      print(index);
      print(length);
      index++;
      setReponse("reponse");
      notifyListeners();
      print("detn");
    } else
      setReponse("fin des questions");
  }

  void setTrueBool() {
    this.vrai = true;
    //this.faux = false;
    notifyListeners();
  }

  void setFalseBool() {
    this.vrai = false;
    this.faux = true;
    notifyListeners();
  }

  void setReponse(String reponse) {
    this.reponse = reponse;
    notifyListeners();
  }

  void addedQuestion(String q) {
    question = q;
    this.added = true;
    notifyListeners();
  }

  void changeTheme() {
    if (this.isOn) {
      this.isOn = false;
    } else {
      this.isOn = true;
    }
    notifyListeners();
  }

  void changeThemeBySettings(bool b) {
    if (b) {
      this.isOn = true;
    } else {
      this.isOn = false;
    }
    notifyListeners();
  }
}
