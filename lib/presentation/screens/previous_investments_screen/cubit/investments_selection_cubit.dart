import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsearch/fsearch.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';
import 'package:vario/domain/models/investment_item/backend/get_stock_by_name_response.dart';
import 'package:vario/domain/models/investment_item/backend/get_stock_by_name_response_found_stocks.dart';
import '../../../../domain/models/investment_item/country.dart';
import '../../../core/helpers/debouncer.dart';

import '../../../../domain/models/investment_item/investment_item.dart';
import '../../../../domain/models/investment_item/regions.dart';
import '../../../../domain/models/investment_item/sector.dart';
import '../../../../domain/models/investment_item/stock.dart';
import '../../../../domain/models/investment_item/stock_risk_class.dart';

import '../../../../locator.dart';

import '../../onboarding_chat_screen/widgets/cubit/chatscreen_cubit.dart';

part 'investments_selection_state.dart';

class InvestmentsSelectionCubit extends Cubit<InvestmentsSelectionState> {
  InvestmentsSelectionCubit() : super(InvestmentsSelectionSelected([])) {
    searchBarController.setListener(onSearchChanged);
  }

  final _debouncer = Debouncer(milliseconds: 500);

  Future<void> search(String searchInput) async {
    if (searchInput.isEmpty) {
      resetSearch(clearFocus: false);
      return;
    }
    emit(InvestmentsSelectionSearchLoading(state.selectedInvestments));
    try {
      final response = await _getDummyData();
      // await StocksApi().getStockByName(searchString: searchInput);

      final _searchResults = //response.foundStocks
      response
          .map((e) => Stock(
              id: e.stockID,
              title: e.name,
              country: Country(e.country),
              logoUrl: e.pictureUrl,
              logoFileType: e.pictureFileType,
              colorHexCode: e.colorHexCode,
              region: Region.fromBackend(e.region),
              sector: Sector.fromBackend(e.sector),
              riskClass: StockRiskClass.fromId(e.risk)))
          .toList();

      emit(InvestmentsSelectionSearchLoaded(
          state.selectedInvestments, searchInput, _searchResults));
    } catch (e, stack) {
      //emit(InvestmentsSelectionError(
      //    GlobalErrorData(e, stackTrace: stack), state.selectedInvestments));
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    searchBarController.dispose();
    await super.close();
  }

  /// Called when the user types something into the searchbar.
  void onSearchChanged() {
    _debouncer.run(() => search(searchBarController.text));
    if (searchBarController.text.isEmpty) resetSearch();
  }

  final FSearchController searchBarController = FSearchController();

  void resetSearch({bool clearFocus = true}) {
    emit(InvestmentsSelectionSelected(state.selectedInvestments));
    if (clearFocus) searchBarController.clearFocus();
    searchBarController.text = '';
  }

  void alreadySelected() {
    emit(InvestmentsSelectionSelected(state.selectedInvestments));
  }

  void selectItem(InvestmentItem investment) {
    final newSelection = List<InvestmentItem>.from(state.selectedInvestments)
      ..add(investment);
    resetSearch();
    emit(InvestmentsSelectionSelected(newSelection));
  }

  void deselectItem(InvestmentItem investment) {
    final newSelection = List<InvestmentItem>.from(state.selectedInvestments)
      ..remove(investment);
    emit(InvestmentsSelectionSelected(newSelection));
  }

  void save(BuildContext context) {
    //TODO: Handle errors
    //TODO: Move chatcubit setAnswer into service

    final chatCubit = context.read<ChatscreenCubit>();

    //Save selected items in portfolio of the user
    // locator<MatchingService>().addToPortfolio(state.selectedInvestments);

    //Set the answer in the onboardingchat
    final String answerText = _getAnswerTextFromSelectedAssets();
    final QuestionAnswerPair previousInvestmentsQuestion =
        chatCubit.lastUnansweredPair;
    chatCubit.setAnswer(
        questionText: previousInvestmentsQuestion.questionText,
        selected: true,
        answerText: answerText);
    chatCubit.submitAnswer(
        context: context,
        questionText: previousInvestmentsQuestion.questionText);
  }

  String _getAnswerTextFromSelectedAssets() {
    String answerText = "Keine.";
    final assets = state.selectedInvestments;
    if (assets.isNotEmpty) {
      answerText = assets[0].title;
      if (assets.length > 1) answerText += " und ${assets.length - 1} weitere.";
    }
    return answerText;
  }

  Future<List<GetStockByNameResponseFoundStocks>> _getDummyData() async {
    return [
      GetStockByNameResponseFoundStocks.fromJson(json.decode('{"foundStocks":[{"stockID":"NTES","name":"Netease","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/logos/NTES.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165625Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=11eb574d8dde57bf57cb4382919e660a40e0f07b785b90f007bb3a06861f34b17d1fdfbb9503de2296640d5bea8dfe766277939fe7510744a06056fd4ab531ef0aa36f7152abc821078ce89443b77340ca0f9f64338d450d229fd1fe7e9f4d83e35e74f319afbeef8951ed5d6fb5a6c01aa92e9157768f084a6832e9e0270d9f640a26cae51717cf6d2b49a90b3ac8e8b94f82679d7115503c99fd8c604678ba9f37ff9651019fcbd6a49ee1962753e7ad594c601a32b87da616575f1a8fd4da1034d9e8fb659b869427979aa96885189664e9f9c24e52947d31b9df324b514cbecdcc88ea8e1a0b2aaef597f5115d793a5303831818be6f89f1e22c68e9a46f","pictureFileType":"svg","colorHexCode":"D23C3F","country":"CN","region":{"id":"asia","name":"Asien"},"sector":{"id":"communication","name":"Kommunikation","emoji":"iphone","color":"#F1C453"},"risk":"growth"},{"stockID":"TSLA","name":"Tesla","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/logos/TSLA.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165631Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=7ea9cd4d816d508c3c6ce3a442cb676106d50c1fd64ef50807180b30e12bf5bd9c7db918d435d76c2d8848dc107e9a76fd72e7f5d4a9be151331d0856151e8e6e6800559328430bf6651b2559496e11aff3476b97a376f2942f75e0da0c4dc070750e469aaf5abdc79ccf7f5218704e714ab3bceda7d1bb284a78d3e19891b0f9bbc5254bcffdf7da26acad268a8d6eff4ef3d257143ae655053acb945e85d8b0f6528ace64b4d3bc60d16b71cfa81e602e5a1dc28f35c9c90bb176f6ea5fcf58fde97ff9712bfe42d513aed0eff64938905a5b68e3cbfeec2fe7e2b5776644c2f61df561d6a7e79e7ebd129e445e383e84a2ca4f9154e1c34c41fb9f518da4b","pictureFileType":"svg","colorHexCode":"E82127","country":"US","region":{"id":"northAmerica","name":"Nordamerika"},"sector":{"id":"durables","name":"Gebrauchsgüter","emoji":"shopping_bags","color":"#0DB39E"},"risk":"growth"}]}'))
    ];
  }
}
