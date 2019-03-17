import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key, {String param1}){
    if(param1 != null){
      String value = _localizedValues[key] ?? '** $key not found';
      value = value.replaceAll(RegExp(r'{{param}}'), param1);
      return value;
    }else{
      return _localizedValues[key] ?? '** $key not found';
    }
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations>{
  const TranslationsDelegate();

  @override
  //bool isSupported(Locale locale) => ['en','es'].contains(locale.languageCode);
  bool isSupported(Locale locale) => ['es'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}