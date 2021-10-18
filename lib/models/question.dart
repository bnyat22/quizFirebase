class Question {
  String questionText;
  bool isCorrect;
  String reponse;
  Question(
      {required this.questionText,
      required this.isCorrect,
      required this.reponse});
  String getReponse() => reponse;
  String get questionTexte => questionText;
  get isCorrectr => isCorrect;
  set isCorrectR(bool b) {
    isCorrect = b;
  }

  Map<String, dynamic> toJson() => {
        'questionText': questionText,
        'isCorrect': isCorrect,
        'reponse': reponse,
      };

  set questionTextR(String q) {
    this.questionText = q;
  }

  set reponseR(String rep) {
    this.reponse = reponse;
  }
}
