abstract class TextMessage {
  final String content;
  final String id;
  bool alreadyShown;
  TextMessage({this.content, this.id, this.alreadyShown = false});
}

class TextSimple extends TextMessage {
  TextSimple(String content, String id) : super(content: content, id: id);
}
