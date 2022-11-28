import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LANGUAGE_CODE = 'languageCode';

//languages code
const String RUSSIAN = 'ru';
const String ENGLISH = 'en';
const String FRENCH = 'fr';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LANGUAGE_CODE) ?? RUSSIAN;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case RUSSIAN:
      return const Locale(RUSSIAN, '');
    case ENGLISH:
      return const Locale(ENGLISH, "");
    case FRENCH:
      return const Locale(FRENCH, "");

    default:
      return const Locale(RUSSIAN, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
