import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vario/presentation/core/widgets/flushbar.dart';

import '../../core/theme/my_styles.dart';
import '../../core/widgets/bottom_confirm_button.dart';
import '../swipe_screen/cubit/swipe_cubit.dart';

class EmptySearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        const _AnimationCircle(),
        const Spacer(flex: 1),
        const _TextBlock(),
        BottomConfirmButton(
          'Filter zurücksetzen',
          onTap: () {
            // context.read<SwipeCubit>().resetFilterAndSearchAgain();
            showErrorBar(context, 'In der Hauptversion implementiert :)');
          },
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _TextBlock extends StatelessWidget {
  const _TextBlock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Oops..',
          style: MyStyles.titleText,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            'Es gibt leider keine Aktien mehr, die deinen Sucheinstellungen entsprechen. Setze deine Filter zurück, um weitere Aktien zu finden.',
            style: MyStyles.analyseText.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _AnimationCircle extends StatelessWidget {
  const _AnimationCircle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: AvatarGlow(
        glowColor: Colors.grey,
        endRadius: 120.0,
        duration: const Duration(milliseconds: 1500),
        repeat: true,
        showTwoGlows: true,
        child: Material(
          shape: const CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/vario-icon.svg',
              height: 60,
            ),
            radius: 50.0,
          ),
        ),
      ),
    );
  }
}
