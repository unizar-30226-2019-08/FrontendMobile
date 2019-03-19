import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/navbars/main_navbar.dart';
import 'package:flutter/rendering.dart';

//void main() => runApp(MyApp());
void main(){
  debugPaintSizeEnabled = true; //
  runApp(MyApp());}

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
      home: Prueba()
    );
  }
}

class Prueba extends StatelessWidget {
  Prueba();
  @override
  Widget build(BuildContext context) {
    return MainNavbar();
  }
}