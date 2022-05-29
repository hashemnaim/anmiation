part of 'investments_selection_cubit.dart';

abstract class InvestmentsSelectionState extends Equatable {
  final List<InvestmentItem> selectedInvestments;
  // final bool searchMode;

  const InvestmentsSelectionState(
    this.selectedInvestments,
  );

  @override
  List<Object> get props => [selectedInvestments];
}

class InvestmentsSelectionSelected extends InvestmentsSelectionState {
  InvestmentsSelectionSelected(List<InvestmentItem> selectedInterests)
      : super(selectedInterests);
}

class InvestmentsSelectionSearchLoading extends InvestmentsSelectionState {
  InvestmentsSelectionSearchLoading(List<InvestmentItem> selectedItems)
      : super(selectedItems);
}

class InvestmentsSelectionSearchLoaded extends InvestmentsSelectionState {
  final List<InvestmentItem> searchResults;
  final String searchTerm;

  InvestmentsSelectionSearchLoaded(List<InvestmentItem> selectedInvestments,
      this.searchTerm, this.searchResults)
      : super(selectedInvestments);

  @override
  List<Object> get props => [selectedInvestments, searchResults, searchTerm];
}

class InvestmentsSelectionError extends InvestmentsSelectionState {


  InvestmentsSelectionError(List<InvestmentItem> selectedItems)
      : super(selectedItems);
}
