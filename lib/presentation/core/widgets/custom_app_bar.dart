import 'dart:math' as math;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../theme/my_styles.dart';
import 'flushbar.dart';
import 'svg.dart';

import '../../../locator.dart';
import '../../routing/navigation_service.dart';

import '../theme/my_colors.dart';

/// App Bar with Vario logo
class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Defaults to [BackIconButton]. Pass a [Container] or [SizedBox] to show nothing.
  final Widget leftIcon;
  final List<Widget> rightIcons;

  const CustomLogoAppBar({Key key, this.leftIcon, this.rightIcons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leftIcon ?? const BackIconButton(),
      title: SvgPicture.asset('assets/icons/vario-word.svg'),
      actions: rightIcons,
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// App Bar with title of the screen
class CustomScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// Defaults to [BackIconButton]. Pass a [SizedBox] to show nothing.
  final Widget leftIcon;

  /// Defaults to SettingsButton.
  final List<Widget> rightIcons;

  final String screenTitle;

  const CustomScreenAppBar(this.screenTitle,
      {Key key, this.leftIcon, this.rightIcons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            leftIcon ?? const BackIconButton(),
            if (leftIcon is! SizedBox) const SizedBox(width: 20),
            Text(screenTitle,
                style: MyStyles.boldText24.copyWith(letterSpacing: -0.36)),
          ]),
      actions: rightIcons ?? const [SettingsButton()],
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // locator<NavigationService>().navigateTo(SettingsScreen.url);
          showErrorBar(context, 'In der Hauptversion implementiert :)');
        },
        icon: PlatformSvg.asset('assets/icons/settings.svg'));
  }
}

class BackIconButton extends StatelessWidget {
  const BackIconButton({Key key, this.color = MyColors.constDarkGrey})
      : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().goBack();
      },
      child: Center(
        child: Transform.rotate(
          angle: 180 * math.pi / 180,
          child: SvgPicture.asset(
            'assets/icons/more-large.svg',
            height: 16,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({Key key});

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset('assets/icons/filter.svg', height: 12);
    //TODO: Rebuild onChange of ActiveFilter.
    // return BlocBuilder<FilterCubit, FilterState>(
    //   builder: (context, state) {
    return IconButton(
      icon:
          // state.activeFilters > 0
          //     ? Badge(
          //         elevation: 0,
          //         position: BadgePosition.bottomEnd(end: 0),
          //         badgeContent: Text(state.activeFilters.toString(),
          //             style: const TextStyle(color: Colors.white)),
          //         borderSide: const BorderSide(color: Colors.white, width: 1.0),
          //         badgeColor: MyColors.textBlack,
          //         child: icon,
          //       )              :
          icon,
      onPressed: () {
        showErrorBar(context, 'In der Hauptversion implementiert :)');
        // showCupertinoModalBottomSheet(
        //     topRadius: const Radius.circular(20),
        //     context: context,
        //     builder: (context) => FilterBottomSheet());
      },
      //   );
      // },
    );
  }
}
