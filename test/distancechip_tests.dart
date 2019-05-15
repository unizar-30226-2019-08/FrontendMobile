/*
 * FICHERO:     distancechip_tests.dart
 * DESCRIPCIÓN: clases relativas a los tests del widget DistanceChip
 * CREACIÓN:    29/03/2019
 */
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong/latlong.dart';
import 'package:bookalo/utils/test_utils.dart';

import 'package:bookalo/widgets/detailed_product/distance_chip.dart';

void main() {

  /*
   *  TEST 1 - Comprueba distancias cortas
   */ 
  testWidgets("DistanceChip -  muy cerca", (WidgetTester tester) async{
    await tester.pumpWidget(makeTestableWidget(
      child: DistanceChip(
        userPosition: LatLng(0.0, 0.0),
        targetPosition: LatLng(0.0, 0.0)
        )
      )
    );
    await tester.pumpAndSettle();
    expect(find.text('very_close'), findsOneWidget);
  });

  /*
   *  TEST 2 - Comprueba distancias en kilómetros
   */   
  testWidgets("DistanceChip - kilómetros", (WidgetTester tester) async{
    await tester.pumpWidget(makeTestableWidget(
      child: DistanceChip(
        userPosition: LatLng(1.0, 0.0),
        targetPosition: LatLng(0.0, 0.0)
        )
      )
    );
    await tester.pumpAndSettle();
    expect(find.text('111 km'), findsOneWidget);
  });

  /*
   *  TEST 3 - Comprueba distancias en metros
   */   
  testWidgets("DistanceChip - metros", (WidgetTester tester) async{
    await tester.pumpWidget(makeTestableWidget(
      child: DistanceChip(
        userPosition: LatLng(0.005, 0.0),
        targetPosition: LatLng(0.0, 0.0)
        )
      )
    );
    await tester.pumpAndSettle();
    expect(find.text('556 m'), findsOneWidget);
  });     
}