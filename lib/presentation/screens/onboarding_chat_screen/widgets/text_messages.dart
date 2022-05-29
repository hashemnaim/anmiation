// import 'package:flutter/material.dart';
// import '../../../../domain/models/text_message.dart';
// import '../../../../domain/models/text_question.dart';

// import 'animated_message.dart';

// class TextMessages extends StatefulWidget {
//   final List<TextMessage> messages;
//   static const int deltaSecs = 5;

//   const TextMessages({Key key, this.messages}) : super(key: key);

//   @override
//   _TextMessagesState createState() => _TextMessagesState();
// }

// class _TextMessagesState extends State<TextMessages> {
//   List<TextMessage> _messagesToBeShown = [];
//   int _countForOffset = TextMessages.deltaSecs;

//   void _callToggleIsAnswered(TextQuestion question) {
//     setState(() {
//       question.setAnswer(question.answer, true);
//       updateShownMessages();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     updateShownMessages();
//   }

//   void updateShownMessages() {
//     int indexLastUnansweredQuestion =
//         widget.messages.indexWhere((element) => (element is TextQuestion && element.isAnswered == false));
//     _messagesToBeShown = widget.messages
//         .sublist(0, indexLastUnansweredQuestion == -1 ? widget.messages.length : indexLastUnansweredQuestion + 1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (TextMessage mes in _messagesToBeShown) ..._buildAnimatedTextMessage(mes),
//       ],
//     );
//   }

//   List<Widget> _buildAnimatedTextMessage(TextMessage mes) {
//     if (mes.alreadyShown) {
//       _countForOffset = 0;
//     } else {
//       mes.alreadyShown = true;
//       _countForOffset += TextMessages.deltaSecs;
//     }
//     if (mes is TextQuestion) {
//       return [
//         AnimatedMessage(
//           message: mes,
//           offsetInSec: _countForOffset - TextMessages.deltaSecs,
//           callToggleIsAnswered: (TextQuestion question) {
//             _callToggleIsAnswered(question);
//           },
//         ),
//       ];
//     }
//     if (mes is TextSimple) {
//       return [
//         AnimatedMessage(
//           message: mes,
//           offsetInSec: _countForOffset - 5,
//         ),
//       ];
//     }
//   }
// }
