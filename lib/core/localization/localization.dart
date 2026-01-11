import 'package:flutter/cupertino.dart';

import 'src/ru_ru.dart';
import 'src/en_us.dart';

Map<Locale, Map<String, dynamic>> get localizationList => {
  Locale("ru", "RU"): ruRU,
  Locale("en", "US"): enUS,
};