/*
 * FICHERO:     main.dart
 * DESCRIPCIÓN: punto de entrada de la ejecución y configuraciones básicas
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/buy_and_sell.dart';

void main() => runApp(MyApp());


/*
 *  CLASE:        MyApp
 *  DESCRIPCIÓN:  widget principal de la aplicación. Establece configuración general
 *                y declara BuyAndSell como widget principal 
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
          //const Locale('en', 'US'),
          const Locale('es', 'ES'),
      ],      
      home: BuyAndSell()
    );
  }
}