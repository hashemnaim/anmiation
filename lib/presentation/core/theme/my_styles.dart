import 'package:flutter/material.dart';

import 'my_colors.dart';

class MyStyles {
  static final theme = ThemeData(
      fontFamily: MyStyles.FONTFAMILY,
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: MyColors.textBlack,
        unselectedItemColor: MyColors.grey,
        unselectedLabelStyle:
            MyStyles.normalText10.copyWith(color: MyColors.grey),
        selectedLabelStyle:
            MyStyles.mediumText10.copyWith(color: MyColors.constDarkGrey),
        backgroundColor: MyColors.canvasColor,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: MyColors.constDarkGrey));

  static const String FONTFAMILY = "Gotham";
  static const double LETTERSPACING = 0.0;
  static const bold = FontWeight.w700;
  static const book = FontWeight.w300;
  static const medium = FontWeight.w500;

  static const TextStyle chatText = TextStyle(
      fontSize: 15,
      fontWeight: book,
      letterSpacing: LETTERSPACING,
      color: MyColors.constDarkGrey,
      height: 1.1);

  static TextStyle titleText = TextStyle(
    fontSize: 20,
    fontWeight: bold,
    letterSpacing: LETTERSPACING,
    color: MyColors.textBlack,
  );
  static TextStyle bigText = TextStyle(
    fontSize: 60,
    letterSpacing: LETTERSPACING,
    color: MyColors.textBlack,
  );
  static TextStyle smallText = TextStyle(
    fontSize: 12,
    letterSpacing: LETTERSPACING,
    color: MyColors.textBlack,
  );

  static TextStyle mediumText10 = TextStyle(
      fontSize: 10,
      fontWeight: medium,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle mediumText12 = TextStyle(
      fontSize: 12,
      fontWeight: medium,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle mediumText13 = TextStyle(
      fontSize: 13,
      fontWeight: medium,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle mediumText15 = TextStyle(
      fontSize: 15,
      fontWeight: medium,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle normalText10 = TextStyle(
      fontSize: 10,
      fontWeight: book,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle normalText12 = TextStyle(
      fontSize: 12,
      fontWeight: book,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle normalText14 = TextStyle(
      fontSize: 14,
      fontWeight: book,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  //TODO: Replace with [normalText]
  static TextStyle normalText15 = TextStyle(
      fontSize: 15,
      fontWeight: book,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle normalText16 = TextStyle(
      fontSize: 16,
      fontWeight: book,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText8 = TextStyle(
      fontSize: 8,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText10 = TextStyle(
      fontSize: 10,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText12 = TextStyle(
      fontSize: 12,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText14 = TextStyle(
      fontSize: 14,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText18 = TextStyle(
      fontSize: 18,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText20 = TextStyle(
      fontSize: 20,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText21 = TextStyle(
      fontSize: 21,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText24 = TextStyle(
      fontSize: 24,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle boldText30 = TextStyle(
      fontSize: 30,
      fontWeight: bold,
      letterSpacing: LETTERSPACING,
      color: MyColors.textBlack);

  static TextStyle descriptionText = TextStyle(
    fontFamily: FONTFAMILY,
    fontWeight: book,
    fontSize: 15,
    height: 1.5,
    letterSpacing: LETTERSPACING,
    color: MyColors.textBlack,
  );

  static const TextStyle infoText = TextStyle(
    fontFamily: FONTFAMILY,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: MyColors.constDarkGrey,
  );

  static TextStyle normalText = TextStyle(
    fontFamily: FONTFAMILY,
    fontWeight: book,
    fontSize: 15,
    height: 1.0,
    letterSpacing: LETTERSPACING,
    color: MyColors.textBlack,
  );

  // TODO: Rename style.
  // It's also used on various other screens
  static TextStyle analyseText = TextStyle(
    letterSpacing: LETTERSPACING,
    fontSize: 16,
    fontWeight: book,
    color: MyColors.textBlack,
  );

  static TextStyle greyMediumText10 = TextStyle(
    fontSize: 10,
    color: MyColors.grey,
    fontWeight: medium,
  );

  static TextStyle greyMediumText11 = greyMediumText10.copyWith(fontSize: 11);

  static TextStyle mediumWhiteText15 =
      mediumText15.copyWith(color: Colors.white);

  static TextStyle consultantOpinionText = TextStyle(
    fontSize: 14,
    letterSpacing: LETTERSPACING,
    fontWeight: book,
    fontFamily: FONTFAMILY,
    height: 1.5,
    color: MyColors.textBlack,
  );

  static TextStyle analysenTitleText = TextStyle(
    fontSize: 13,
    letterSpacing: LETTERSPACING,
    fontWeight: medium,
    fontFamily: FONTFAMILY,
    color: MyColors.textBlack,
  );

  static TextStyle nameTextStart = TextStyle(
    fontFamily: FONTFAMILY,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: MyColors.textBlack,
  );

  static TextStyle subTitle = TextStyle(
    fontFamily: FONTFAMILY,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: MyColors.textBlack.withOpacity(0.5),
  );

  static ButtonStyle transparentButton = ButtonStyle(
    overlayColor:
        MaterialStateColor.resolveWith((states) => Colors.transparent),
  );

  static CheckboxThemeData checkboxThemeData = CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColors.mainGreen));

  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.constDarkGrey.withOpacity(0.1)));
}
