import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vario/presentation/screens/onboarding_chat_screen/widgets/cubit/chatscreen_cubit.dart';
import 'package:vario/presentation/screens/previous_investments_screen/cubit/investments_selection_cubit.dart';
import 'package:vario/presentation/screens/swipe_screen/swipe_screen.dart';

import 'data/chat/chat_start.dart';
import 'locator.dart';
import 'presentation/core/theme/my_styles.dart';
import 'presentation/routing/navigation_service.dart';
import 'presentation/routing/route_generator.dart';
import 'presentation/screens/swipe_screen/cubit/swipe_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await initializeDateFormatting('de_DE', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SwipeCubit()..fetchNextInvestments(initialLoad: true),
        ),
        BlocProvider(create: (_) => ChatscreenCubit(getChatStartPairs())),
        BlocProvider(create: (_) => InvestmentsSelectionCubit()),
      ],
      child: MaterialApp(
        title: 'Vario',
        theme: MyStyles.theme,
        initialRoute: SwipeScreen.url,
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
