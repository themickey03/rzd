import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

class LocalizationService extends ChangeNotifier {

  LocalizationService() {
    Future.delayed(Duration(milliseconds: 1), () {
      notifyListeners();
    });
  }

  Locale currentLocale = Locale("ru", "RU");

  List<Locale> availableLocales = [
    Locale("ru", "RU"),
    Locale("en", "US"),
  ];

  List<LocalizationsDelegate> availableDelegates = [
    MapLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  void switchLocale() {
    currentLocale = availableLocales.firstWhere((e) => e != currentLocale);
    notifyListeners();
  }

  String translate(String key) {
    return key.i18n();
  }

  void setTranslations(Map<Locale, Map<String, dynamic>> texts) {
    MapLocalization.delegate.translations = texts;
  }

}