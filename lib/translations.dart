/*
 * FICHERO:     translations.dart
 * DESCRIPCIÓN: soporte para internacionalización
 * CREACIÓN:    12/03/2019
 */
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
 *  CLASE:        Translations
 *  DESCRIPCIÓN:  clase estática para internacionalización. Obtiene la traducción
 *                de una cadena en función del idioma del dispositivo de acuerdo
 *                a lo definido en los ficheros .json de /locale. Solo se ha docuemntado
 *                el método .text() ya que es el único que se usa desde el exterior de la clase
 */

class Translations {
  Translations(
    this._locale, {
    this.isTest = false,
  });
  final Locale _locale;
  bool isTest;
  Map<String, String> _sentences;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  Future<Translations> loadTest(Locale locale) async {
    return Translations(locale);
  }

  Future<Translations> load() async {
    String data =
        await rootBundle.loadString('locale/i18n_${_locale.languageCode}.json');

    Map<String, dynamic> _result = json.decode(data);
    _sentences = Map();
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });
    return Translations(_locale);
  }

  /*
   * Pre:   key es una clave definida en los ficheros .json de /locale
   *        y param1 puede ser opcionalmente una cadena de texto
   * Post:  ha devuelto la cadena con clave key en el fichero .json del
   *        idioma del usuario y, en caso de haberse especificado param1
   *        y contener una etiqueta param1 dicha cadena, la ha sustituido
   */
  String text(String key, {List<String> params}) {
    if (isTest) {
      return key;
    }
    if (params == null) {
      return _sentences[key] ?? '** $key not found';
    }
    String output = _sentences[key] ?? '** $key not found';
    int counter = 1;
    params.forEach((param) {
      output = output.replaceAll(
          RegExp(r"{{param" + counter.toString() + "}}"), param);
      counter++;
    });
    return output;
  }
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate({
    this.isTest = false,
  });
  final bool isTest;

  @override
  bool isSupported(Locale locale) => ['es', 'en', 'de', 'fr'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) async {
    Translations localizations = Translations(locale, isTest: isTest);
    if (isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    return localizations;
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
