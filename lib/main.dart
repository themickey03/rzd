import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rzd/core/service/rzd_service.dart';
import 'package:rzd/pages/home/home_page.dart';
import 'package:rzd/pages/train_details/train_details_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<RzdService>(create: (_) => RzdService()),
      ],
      child: MyApp(),
    )
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            Map<String, String> params = state.uri.queryParameters;
            return TrainDetailsPage(
              trainDate: params["train"],
              trainNumber: params["date"]
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
    return CupertinoApp.router(
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoColors.inactiveGray,
        scaffoldBackgroundColor: CupertinoColors.white
      ),
      title: 'Поезд 128E',
      routerConfig: _router,
    );
  }
}
