/*
 * FICHERO:     screenshots_tests.dart
 * DESCRIPCIÓN: clases relativas a la toma automática de capturas de pantalla
 * CREACIÓN:    02/04/2019
 */
import 'package:flutter_test/flutter_test.dart';
import 'package:bookalo/utils/test_utils.dart';
import 'package:screenshots/config.dart';
import 'package:screenshots/capture_screen.dart';

import 'package:bookalo/pages/buy_and_sell.dart';

void main() {
  /*
   *  TEST 1 - Comprueba apertura del botón
   */ 
  testWidgets("Screenshot compra", (WidgetTester tester) async{
    final Map config = Config().config;
    await tester.pumpWidget(makeTestablePage(
      child: BuyAndSell()
      )
    );
    await tester.pumpAndSettle();
    await screenshot(tester, config, 'myscreenshot1');
  });
}