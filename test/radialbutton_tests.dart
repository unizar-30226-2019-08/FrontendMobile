/*
 * FICHERO:     radialbutton_tests.dart
 * DESCRIPCIÓN: clases relativas a los tests del widget RadialButton
 * CREACIÓN:    02/04/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookalo/utils/test_utils.dart';

import 'package:bookalo/widgets/detailed_product/radial_button.dart';

void main() {
  /*
   *  TEST 1 - Comprueba apertura del botón
   */ 
  testWidgets("RadialButton - Apertura", (WidgetTester tester) async{
    await tester.pumpWidget(makeTestableWidget(
      child: RadialButton()
      )
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.more_horiz), findsNothing);
    expect(find.byIcon(Icons.close), findsOneWidget);
  });

  /*
   *  TEST 2 - Comprueba cierre del botón
   */ 
  testWidgets("RadialButton - Cierre", (WidgetTester tester) async{
    await tester.pumpWidget(makeTestableWidget(
      child: RadialButton()
      )
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.byIcon(Icons.more_horiz), findsOneWidget);

  });

  /*
   *  TEST 2 - Comprueba cierre del botón
   */ 
  testWidgets("RadialButton - Cierre", (WidgetTester tester) async{
    await tester.pumpWidget(makeTestableWidget(
      child: RadialButton()
      )
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.byIcon(Icons.more_horiz), findsOneWidget);

  });
}