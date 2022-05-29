import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:vario/services/investment_item_service.dart';

import '../../../../domain/models/investment_item/investment_item.dart';
import '../../../../locator.dart';
import '../../../core/widgets/flushbar.dart';

part 'swipe_state.dart';

enum SwipeAction { Like, Dislike }

class SwipeCubit extends Cubit<SwipeState> {
  SwipeCubit() : super(SwipeInitial()) {}

  void emitLoadedOrEmpty() {
    final upcomingItems = List<InvestmentItem>.from(
        locator<InvestmentItemService>().upcomingSwipeItems);

    if (upcomingItems.isEmpty) {
      if (locator<InvestmentItemService>().isFetching) {
        emit(SwipeLoading());
      } else {
        emit(SwipeEmpty());
      }
    } else {
      emit(SwipeLoaded(upcomingItems));
    }
  }

  static const fetchAmount = 10;

  ///fetch possible investment suggestions, sorted by relevance for the user and add [amount] of new ordered investments to the queue.
  Future<void> fetchNextInvestments(
      {int amount = fetchAmount, bool initialLoad = false}) async {
    // Avoid throwing errors when the cubit is called after creation.
    // if (!locator<AuthService>().isLoggedIn) return;

    if (initialLoad || state.upcomingItems.isEmpty) {
      log("Loading next items (visible)...");
      emit(SwipeLoading());
    } else {
      log("Loading next items (in background)...");
    }
    try {
      debugPrint("Start ${DateTime.now()}");

      await locator<InvestmentItemService>().fetchNextSwipes(amount);

      emitLoadedOrEmpty();
    } catch (e, stack) {
      // emit(SwipeError(GlobalErrorData(e, stackTrace: stack)));
      rethrow;
    } finally {
      debugPrint("End ${DateTime.now()}");
    }
  }

  /// Used after logging out so there are no more swipes from the previous user.
  void clearQueue() {
    if (state is SwipeLoaded) {
      emit(SwipeLoaded([]));
    }
  }

  Future<void> onSwiped(SwipeAction action, BuildContext context) async {
    ///amount of remaining items before more relevant items are preloaded for the user.
    const int reloadThreshold = 5;
    assert(reloadThreshold > 1 && fetchAmount > reloadThreshold);

    final List<InvestmentItem> upcomingItems =
        locator<InvestmentItemService>().upcomingSwipeItems;
    try {
      if (upcomingItems.length < state.upcomingItems.length) {
        state.upcomingItems.removeRange(1, state.upcomingItems.length);
      } else {
        assert(
            state.currentItem != null && state.currentItem == upcomingItems[0]);
      }

      final InvestmentItem currentDisplayedItem = state.currentItem;

      //like or dislike the item.
      if (action == SwipeAction.Like) {
        await likeItem(currentDisplayedItem, context);
      } else if (action == SwipeAction.Dislike) {
        await dislikeItem(currentDisplayedItem, context);
      } else {
        throw ArgumentError.value(action, 'action');
      }

      //dismiss the item.
      //TODO: Handle async errors: If liking/disliking failed, the current item should reappear.
      locator<InvestmentItemService>().dismissCurrentItem();
      emitLoadedOrEmpty();
      // if there are less than [reloadThreshold] items preloaded, preload some more.
      if (upcomingItems.length <= reloadThreshold) {
        await fetchNextInvestments(initialLoad: upcomingItems.isEmpty);
      } else {
        debugPrint("${upcomingItems.length} remaining items.");
      }
    } catch (e, stackTrace) {
      // emit(SwipeError(GlobalErrorData(e, stackTrace: stackTrace)));
      rethrow;
    }
  }

  Future<void> likeItem(InvestmentItem item, BuildContext context) async {
    // await locator<MatchingService>().likeItem(item);
    showToast("${item.title} geliked");
  }

  Future<void> dislikeItem(InvestmentItem item, BuildContext context) async {
    // await locator<MatchingService>().dislikeItem(item);
    showToast("${item.title} gedisliked");
  }
}
