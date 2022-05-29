import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get_it/get_it.dart';

import 'presentation/routing/navigation_service.dart';
import 'services/investment_item_service.dart';

GetIt locator = GetIt.instance;

// hier werden Instanzen der Serviceklassen erstellt, die von der ganzen App aus aufgerufen werden können.
void setupLocator() async {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<EmojiParser>(() => EmojiParser());
  setupUserDependentLocator();
}

/// creates new instances of services when required
void setupUserDependentLocator() {
  locator.registerLazySingleton<InvestmentItemService>(
      () => InvestmentItemService());
}
