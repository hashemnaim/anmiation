import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fsearch/fsearch.dart';

import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import '../cubit/investments_selection_cubit.dart';

class InvestmentsSearchbar extends StatefulWidget {
  @override
  State<InvestmentsSearchbar> createState() => _InvestmentsSearchbarState();
}

class _InvestmentsSearchbarState extends State<InvestmentsSearchbar> {
  @override
  Widget build(BuildContext context) {
    final _controller = context.select((InvestmentsSelectionCubit cubit) {
      setState(() {});
      return cubit.searchBarController;
    });
    return FSearch(
      controller: _controller,
      style: MyStyles.analyseText,
      height: 50,
      hints: ['Suche nach Investments', ''],
      hintSwitchEnable: false,
      backgroundColor: MyColors.searchBarGrey,
      cursorColor: Colors.black,
      prefixes: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SvgPicture.asset('assets/icons/search.svg'),
        ),
      ],
      suffixes: [
        if (_controller.focus)
          Container(
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: MyStyles.infoText,
                    primary: MyColors.grey),
                onPressed: () {
                  context.read<InvestmentsSelectionCubit>().resetSearch();
                },
                child: const Text('ABBRECHEN'),
              ))
      ],
    );
  }
}
