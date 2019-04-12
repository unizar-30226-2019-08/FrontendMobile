/*
 * FICHERO:     main.dart
 * DESCRIPCIÓN: punto de entrada de la ejecución y configuraciones básicas
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/buy_and_sell.dart';
import 'package:bookalo/pages/login.dart';

void main() async {
  bool _isAuthenticated;
  await FirebaseAuth.instance.currentUser().then((user){
    _isAuthenticated = (user != null);
  });
  runApp(MyApp(isAuthenticated: _isAuthenticated));
}

/*
 *  CLASE:        MyApp
 *  DESCRIPCIÓN:  widget principal de la aplicación. Establece configuración general
 *                y declara BuyAndSell como widget principal 
 */
class MyApp extends StatelessWidget {

  final bool isAuthenticated;

  MyApp({Key key, this.isAuthenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'Bookalo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //const Locale('en', 'US'),
          const Locale('es', 'ES'),
        ],
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: ((context, snapshot){
                  if(snapshot.hasData){
                    return BuyAndSell();
                  }else{
                    return Login();
                  }
                }),
              );
            });
          case '/login':
            return MaterialPageRoute(builder: (_) => Login());
          case '/buy_and_sell':
            return MaterialPageRoute(builder: (_) => BuyAndSell());            
        }
      },
    );
  }
}
