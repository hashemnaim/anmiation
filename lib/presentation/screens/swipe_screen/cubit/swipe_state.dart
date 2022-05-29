part of 'swipe_cubit.dart';

abstract class SwipeState extends Equatable {
  /// Queue of all suggestions that might be relevant for the user and that can be swiped.
  final List<InvestmentItem> upcomingItems;

  /// The item that is currently displayed to the user.
  ///
  /// Can be swiped on the [SwipeScreen].
  InvestmentItem get currentItem => upcomingItems[0];

  const SwipeState() : this.upcomingItems = const [];
  const SwipeState.specified(this.upcomingItems);

  @override
  List<Object> get props => [upcomingItems];
}

class SwipeInitial extends SwipeState {}

class SwipeLoading extends SwipeState {}

/// Represents a state when there a no (more) assets to display/swipe.
class SwipeEmpty extends SwipeState {}

class SwipeError extends SwipeState {
  // @override
  // final GlobalErrorData error;

  // const SwipeError(this.error);
}

class SwipeLoaded extends SwipeState {
  SwipeLoaded(List<InvestmentItem> items) : super.specified(items);
}
