import 'package:flutter/cupertino.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:rzd/core/service/localization_service.dart';
import 'package:rzd/core/service/rzd_service.dart';
import 'package:rzd/core/localization/localization.dart';
import 'package:rzd/pages/home/home_page.dart';
import 'package:rzd/pages/train_details/train_details_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        Provider<RzdService>(create: (_) => RzdService()),
        ChangeNotifierProvider<LocalizationService>(create: (_) => LocalizationService())
      ],
      child: MyApp(),
    )
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CupertinoPage(
          title: "title".i18n(),
          child: HomePage()
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          caseSensitive: false,
          pageBuilder: (BuildContext context, GoRouterState state) {
            Map<String, String> params = state.uri.queryParameters;
            return CupertinoPage(
              title: params["train"],
              child: TrainDetailsPage(
                trainDate: params["date"],
                trainNumber: params["train"],
              )
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationService localizationService = context.watch<LocalizationService>();
    localizationService.setTranslations(localizationList);
    return CupertinoApp.router(
      key: Key("app_with_${context.watch<LocalizationService>().currentLocale}"),
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoColors.white,
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.black,
          textStyle: CupertinoTextThemeData().textStyle.copyWith(color: CupertinoColors.black),
          navLargeTitleTextStyle: CupertinoTextThemeData().navLargeTitleTextStyle.copyWith(color: CupertinoColors.black),
          tabLabelTextStyle: CupertinoTextThemeData().tabLabelTextStyle.copyWith(color: CupertinoColors.black),
          navTitleTextStyle: CupertinoTextThemeData().navTitleTextStyle.copyWith(color: CupertinoColors.black),
        )
      ),
      localizationsDelegates: localizationService.availableDelegates,
      supportedLocales: localizationService.availableLocales,
      locale: localizationService.currentLocale,
      title: localizationService.translate("title"),
      routerConfig: _router,
    );
  }
}
