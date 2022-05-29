import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../domain/models/investment_item/investment_item.dart';
import '../../../domain/models/stock_preview.dart';
import '../../../locator.dart';
import '../../core/theme/my_colors.dart';
import '../../core/theme/my_styles.dart';
import '../../core/widgets/bottom_arrow_confirm_button.dart';
import '../../core/widgets/flushbar.dart';
import '../../core/widgets/investment_item/asset_preview_display.dart';
import '../../core/widgets/ux/default_error.dart';
import '../../core/widgets/ux/default_loading.dart';
import '../../routing/navigation_service.dart';
import 'cubit/investments_selection_cubit.dart';
import 'widgets/investments_searchbar.dart';

class PreviousInvestmentsScreen extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    await showCupertinoModalBottomSheet(
        topRadius: const Radius.circular(20),
        context: context,
        expand: true,
        builder: (context) => PreviousInvestmentsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(padding: EdgeInsets.all(20.0), child: _CardContent()),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({Key key}) : super(key: key);

  static const SizedBox _spacer32 = SizedBox(height: 32);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Deine Investments', style: MyStyles.boldText24),
          const SizedBox(height: 2),
          Text(
            'Füge deine aktuellen Investments hinzu',
            style: MyStyles.analysenTitleText,
          ),
          _spacer32,
          InvestmentsSearchbar(),
          _spacer32,
          BlocBuilder<InvestmentsSelectionCubit,
              InvestmentsSelectionState>(builder: (context, state) {
            if (state is InvestmentsSelectionSearchLoaded) {
              return _buildSearchResults(state, context);
            } else if (state is InvestmentsSelectionSelected) {
              return _buildSelectedStocks();
            } else if (state is InvestmentsSelectionError) {
              return Expanded(
                  child: DefaultError(message: 'Fehler aufgetreten'));
            }
            return const Expanded(child: DefaultLoading());
          }),
          _spacer32,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBackButton(),
              BottomArrowConfirmButton(
                onTap: () {
                  context.read<InvestmentsSelectionCubit>().save(context);
                  locator<NavigationService>().goBack();
                },
              ),
              Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
      InvestmentsSelectionSearchLoaded state, BuildContext context) {
    if (state.searchResults.isEmpty) {
      return const Expanded(
        child: DefaultError(
            message: 'Für deine Anfrage wurden keine Suchergebnisse gefunden.'),
      );
    }
    return Expanded(
        child: ListView.separated(
      separatorBuilder: (_, __) => const Divider(height: 20),
      padding: EdgeInsets.zero,
      itemBuilder: (ctx, i) {
        final stock = state.searchResults[i];
        return InkWell(
            onTap: state.selectedInvestments.contains(stock)
                ? () {
                    showErrorBar(
                        context, 'Du hast diese Aktie bereits ausgewählt.');
                    context.read<InvestmentsSelectionCubit>().alreadySelected();
                  }
                : () {
                    context.read<InvestmentsSelectionCubit>().selectItem(stock);
                  },
            child: AssetPreviewDisplay(StockPreview.fromStock(stock)));
      },
      itemCount: state.searchResults.length,
    ));
  }

  Widget _buildBackButton() {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(const Size(20, 20))),
        child: const Text(
          'ZURÜCK',
          style: MyStyles.infoText,
        ),
        onPressed: () {
          locator<NavigationService>().goBack();
        });
  }

  Widget _buildSelectedStocks() {
    return Expanded(child:BlocBuilder<InvestmentsSelectionCubit,
        InvestmentsSelectionState>(
      builder: (context, state) {
        final List _selectedStocks = state.selectedInvestments;
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 20),
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, i) {
            return (_buildSelectedStockItem(_selectedStocks[i], context));
          },
          itemCount: _selectedStocks.length,
        );
      },
    ));
  }

  Widget _buildSelectedStockItem(InvestmentItem stock, BuildContext context) {
    return Stack(
      children: [
        AssetPreviewDisplay(StockPreview.fromStock(stock)),
        _buildCloseButton(context, stock)
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context, InvestmentItem stock) {
    return Positioned(
      child: Container(
          width: 28,
          height: 28,
          child: Material(
            color: Colors.white,
            child: IconButton(
                icon: SvgPicture.asset('assets/icons/close.svg'),
                color: MyColors.grey,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  context.read<InvestmentsSelectionCubit>().deselectItem(stock);
                }),
          )),
      right: 0,
      top: 11,
    );
  }
}
