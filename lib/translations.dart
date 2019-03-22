/*
 * FICHERO:     translations.dart
 * DESCRIPCIÓN: soporte para internacionalización
 * CREACIÓN:    12/03/2019
 */
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

/*
 *  CLASE:        Translations
 *  DESCRIPCIÓN:  clase estática para internacionalización. Obtiene la traducción
 *                de una cadena en función del idioma del dispositivo de acuerdo
 *                a lo definido en los ficheros .json de /locale. Solo se ha docuemntado
 *                el método .text() ya que es el único que se usa desde el exterior de la clase
 */

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

  /*
   * Pre:   key es una clave definida en los ficheros .json de /locale
   *        y param1 puede ser opcionalmente una cadena de texto
   * Post:  ha devuelto la cadena con clave key en el fichero .json del
   *        idioma del usuario y, en caso de haberse especificado param1
   *        y contener una etiqueta param1 dicha cadena, la ha sustituido
   */
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