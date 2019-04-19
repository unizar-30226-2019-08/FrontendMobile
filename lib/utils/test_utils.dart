/*
 * FICHERO:     test_utils.dart
 * DESCRIPCIÓN: funciones de generación de widgets testables
 * CREACIÓN:    21/03/2019
 */

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookalo/translations.dart';

/*
 * Pre:   child es un Widget
 * Post:  ha devuelto un Widget testable
 */
Widget makeTestableWidget({Widget child}) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
      localizationsDelegates: [
        TranslationsDelegate(isTest: true),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

/*
 * Pre:   child es un Widget con un Scaffold como padre
 * Post:  ha devuelto una página testable
 */
Widget makeTestablePage({Widget child}) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(localizationsDelegates: [
      TranslationsDelegate(isTest: true),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ], home: child),
  );
}
