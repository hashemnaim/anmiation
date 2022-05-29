import 'package:flutter/material.dart';

import '../bottom_confirm_button.dart';

class DefaultError extends StatelessWidget {
  final String message;
  final VoidCallback retryOnPress;

  const DefaultError({Key key, @required this.message, this.retryOnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: retryOnPress != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  BottomConfirmButton(
                    "Erneut versuchen",
                    onTap: retryOnPress,
                  )
                ],
              )
            : Text(message, textAlign: TextAlign.center));
  }
}
