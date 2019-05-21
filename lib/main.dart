/*
 * FICHERO:     main.dart
 * DESCRIPCIÓN: punto de entrada de la ejecución y configuraciones básicas
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/buy_and_sell.dart';
import 'package:bookalo/pages/login.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/utils/fcm_utils.dart';

void main() async {
  bool isAuthenticated = await FirebaseAuth.instance.currentUser() != null;
  runApp(ScopedModel<FilterQuery>(
    model: FilterQuery(),
    child: ScopedModel<ChatsRegistry>(
      model: ChatsRegistry(),
      child: Bookalo(isAuthenticated: isAuthenticated),
    ),
  ));
}

/*
 *  CLASE:        MyApp
 *  DESCRIPCIÓN:  widget principal de la aplicación. Establece configuración general
 *                y declara BuyAndSell como widget principal 
 */

class Bookalo extends StatefulWidget {
  final bool isAuthenticated;
  Bookalo({Key key, this.isAuthenticated}) : super(key: key);

  @override
  _BookaloState createState() => _BookaloState();
}

class _BookaloState extends State<Bookalo> {
  @override
  void initState() {
    super.initState();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        handleChatMessage(message, context);
      },
      onResume: (Map<String, dynamic> message) async {
        handleChatMessage(message, context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        handleChatMessage(message, context);
      },
    );
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.medium, distanceFilter: 100);
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      ScopedModel.of<FilterQuery>(context)
          .updatePosition(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // return ScopedModel<FilterQuery>(
    //   model: FilterQuery(),
    //   child: MaterialApp(
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
              if (widget.isAuthenticated) {
                return BuyAndSell();
              } else {
                return Login();
              }
            });
          case '/login':
            return MaterialPageRoute(builder: (_) => Login());
          case '/buy_and_sell':
            return MaterialPageRoute(builder: (_) => BuyAndSell());
        }
      },
      //),
    );
  }
}
