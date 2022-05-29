import 'package:flutter/material.dart';
import '../theme/my_colors.dart';
import '../theme/my_styles.dart';

class MyTextField extends StatefulWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String label;
  final void Function(String input) onChanged;
  MyTextField({this.obscureText, this.controller, this.label, this.onChanged});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        style: MyStyles.normalText16,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: MyStyles.mediumText15.copyWith(color: MyColors.grey),
            border: MyStyles.textFieldBorder,
            focusedBorder: MyStyles.textFieldBorder,
            enabledBorder: MyStyles.textFieldBorder,
            disabledBorder: MyStyles.textFieldBorder,
            focusedErrorBorder: MyStyles.textFieldBorder,
            errorBorder: MyStyles.textFieldBorder),
        obscureText: widget.obscureText,
      ),
    );
  }
}
