import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';

import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import '../../core/widgets/custom_bottom_navigation_bar/nav_bar_item.dart';
import '../../core/widgets/investment_item/asset_scrollable_card.dart';
import '../../core/widgets/ux/default_error.dart';
import '../empty_search_screen/empty_search_screen.dart';
import 'cubit/swipe_cubit.dart';
import 'util/swipe_button_data.dart';
import 'widgets/loading_animation.dart';

class SwipeScreen extends StatelessWidget {
  static const url = "/swipe-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          const CustomBottomNavigationBar(NavBarItem.Swiping()),
      body: Column(
        children: [
          CustomLogoAppBar(
            leftIcon: Container(),
            // IconButton(
            //   icon: SvgPicture.asset('assets/icons/rewind.svg', height: 20),
            //   onPressed: () {
            //     //TODO: Unswipe
            //     showErrorBar(context, "Unswipe wird noch implementiert :)");
            //   },
            // ),
            rightIcons: const [FilterIconButton()],
          ),
          Expanded(
              child: BlocBuilder<SwipeCubit, SwipeState>(builder: (ctx, state) {
            if (state is SwipeLoading) {
              return const SwipeLoadingAnimation();
            }
            if (state is SwipeEmpty) {
              return EmptySearchScreen();
            }
            if (state is SwipeLoaded) {
              debugPrint(state.currentItem.toString());
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    try {
                      SwipeAction action;
                      if (direction == DismissDirection.startToEnd)
                        action = SwipeAction.Like;
                      else if (direction == DismissDirection.endToStart)
                        action = SwipeAction.Dislike;
                      else
                        throw ArgumentError.value(direction, "direction");
                      await ctx.read<SwipeCubit>().onSwiped(action, ctx);
                    } catch (e, stackTrace) {
                      log(e.toString(), name: "SWIPE_SCREEN");
                      //TODO: Undo swipe here :^)
                    }
                  },
                  child: AssetScrollableCard(
                    item: state.currentItem,
                    swipeButtons: SwipeButtonBehavior(onLike: () async {
                      await context
                          .read<SwipeCubit>()
                          .onSwiped(SwipeAction.Like, context);
                    }, onDislike: () async {
                      await context
                          .read<SwipeCubit>()
                          .onSwiped(SwipeAction.Dislike, context);
                    }),
                  ));
            } else {
              if (state is SwipeError) {
                return DefaultError(
                  message:
                      "Ein unerwarteter Fehler ist aufgetreten und wurde protokolliert.\n\n",
                  retryOnPress: () {
                    context.read<SwipeCubit>().fetchNextInvestments();
                  },
                );
              }

              return DefaultError(
                  message: "No state for ${state.toString()}:(");
            }
          })),
        ],
      ),
    );
  }
}
