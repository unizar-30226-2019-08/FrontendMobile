/*
 * FICHERO:     main.dart
 * DESCRIPCIÓN: punto de entrada de la ejecución y configuraciones básicas
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/buy_and_sell.dart';
import 'package:bookalo/pages/menu_chats.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/widgets/Product_info.dart';
import 'package:bookalo/objects/product.dart';

//void main() => runApp(MyApp());
void main() {
  //debugPaintSizeEnabled = true; //
  runApp(MyApp());
}

/*
 *  CLASE:        MyApp
 *  DESCRIPCIÓN:  widget principal de la aplicación. Establece configuración general
 *                y declara BuyAndSell como widget principal 
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var product2=new Product("mesa", 20, false, "https://github.com/unizar-30226-2019-08/FrontendMobile/blob/master/assets/images/boli.jpg",'esta chulo tambien',true,'nuevo',54);
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
        
        home: new Scaffold(
         body:new Center( child:new ProductInfo(product2))
        )
          
        
    );
  }
}
