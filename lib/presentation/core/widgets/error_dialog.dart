import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../../routing/navigation_service.dart';
import '../theme/my_colors.dart';
import '../theme/my_styles.dart';

/// {@template error_dialog}
///
/// An AlertDialogue that takes the attributes `header`, `subheader` and `onConfirm`, that gets executed when the confirm button of the dialog was pressed
///
/// example:
/// ```dart
/// ErrorDialog.show(
///            context,
///            header: 'Fehler',
///            subheader:'Es ist momentan keine Datenverbindung verfügbar, bitte versuche es später erneut.',
///            onConfirm: () {
///               retrySomething();
///              }),
///            );
/// ```
/// {@endtemplate}
class ErrorDialog extends StatelessWidget {
  /// {@macro error_dialog}
  const ErrorDialog(
      {@required this.onConfirm,
      @required this.header,
      @required this.subheader,
      this.showCancelButton = false});

  final VoidCallback onConfirm;
  final String header;
  final String subheader;
  final bool showCancelButton;

  static Future<void> show(BuildContext context, String text,
      {String header = 'Fehler',
      VoidCallback onConfirm,
      bool showCancelButton = false}) async {
    await showDialog(
        context: context,
        builder: (_) => ErrorDialog(
              header: header,
              subheader: text,
              onConfirm: onConfirm,
              showCancelButton: showCancelButton,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: const EdgeInsets.only(top: 40),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 4),
        title: Text(
          header,
          textAlign: TextAlign.center,
          style: MyStyles.boldText24,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              subheader,
              textAlign: TextAlign.center,
              style: MyStyles.mediumText15.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 10),
            const Divider(height: 10),
          ],
        ),
        actions: [
          _DialogButton('Bestätigen', onPress: onConfirm),
          if (showCancelButton) const _DialogButton('Abbrechen')
        ],
        elevation: 0,
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton(this.label, {Key key, this.onPress}) : super(key: key);

  final VoidCallback onPress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: MyColors.textBlack,
      ),
      width: 360,
      height: 55,
      child: InkWell(
        onTap: () {
          locator<NavigationService>().goBack();
          if (onPress != null) onPress();
        },
        child: Center(
          child: Text(
            label,
            style: MyStyles.mediumWhiteText15,
          ),
        ),
      ),
    );
  }
}
