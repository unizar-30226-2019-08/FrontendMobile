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
import 'package:bookalo/pages/upload_product.dart';
import 'package:bookalo/pages/chat.dart';
import 'package:bookalo/pages/report.dart';
import 'package:bookalo/utils/objects_generator.dart';
import 'package:bookalo/widgets/valoration_card.dart';
import 'package:bookalo/widgets/navbars/report_navbar.dart';
import 'package:bookalo/widgets/image_card.dart';
import 'package:bookalo/widgets/add_image.dart';
import  'dart:io';
import 'package:bookalo/widgets/crear_foto.dart';

void main() {
  runApp(MyApp());
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
    // var product2= Product("mesa", 20, false, "https://github.com/unizar-30226-2019-08/FrontendMobile/blob/master/assets/images/boli.jpg",'esta chulo tambien',true,'Desgastado',54);
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
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return UploadProduct();
                  } else {
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


