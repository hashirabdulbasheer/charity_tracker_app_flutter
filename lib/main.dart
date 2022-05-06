import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'core/misc/app_globals.dart';
import 'core/misc/app_routes.dart';

void main() async {
  await CharityGlobals.initialize();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', '')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', ''),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charity Tracker',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(primarySwatch: Colors.green),
      onGenerateRoute: CharityRouteGenerator.generateRoute,
      initialRoute: '/'
    );
  }
}
