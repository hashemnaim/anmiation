import 'text_message.dart';

abstract class TextQuestion extends TextMessage {
  bool isAnswered = false;
  String answer = '';

  void setAnswer(String ans, [bool toggleIsAnswered]) {
    answer = ans;
    if (toggleIsAnswered == true) {
      isAnswered = !isAnswered;
    }
  }

  TextQuestion({String content, String id, this.answer})
      : super(content: content, id: id);
}

class SliderTextQuestion extends TextQuestion {
  List<String> resultingTextOptions;

  SliderTextQuestion(
      {String content, String id, String answer, this.resultingTextOptions})
      : super(content: content, id: id, answer: answer);
}

class ChipTextQuestion extends TextQuestion {
  List<String> chipOptions;

  ChipTextQuestion({String content, String id, String answer, this.chipOptions})
      : super(content: content, id: id, answer: answer);
}

class CheckboxTextQuestion extends TextQuestion {
  List<String> checkboxOptions;

  CheckboxTextQuestion(
      {String content, String id, String answer, this.checkboxOptions})
      : super(content: content, id: id, answer: answer);
}
