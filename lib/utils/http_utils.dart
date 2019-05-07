/*
 * FICHERO:     http_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de respuestas http
 * CREACIÓN:    03/05/2019
 */

import 'package:tuple/tuple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/objects/filter_query.dart';

final Map<String, String> headers = {'appmovil': 'true'};

Future<Tuple2<List<ProductView>, bool>> parseProducts(FilterQuery query, int currentSize) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  Map<String, String> body = {
    'token': await user.getIdToken(),
    'tags': query.tags,
    'busqueda': 'v',
    'precio_minimo': query.minPrice.round().toString(),
    'precio_maximo': query.maxPrice.round().toString(),
    'calificacion_minima': query.minRating.round().toString(),
    'latitud': '0.1',
    'longitud': '0.1',
    'distancia_maxima': query.maxDistance.round().toString()
  };
  var response = await http.post('https://bookalo.es/api/filter_product',
      headers: headers, body: body);
  print(response.body);
  //Map respuesta = json.decode(response.body);
  // List<String> tagList =
  //     (jsonDecode(respuesta['productos']) as List<dynamic>).cast<String>();
  // print(tagList[0]);
  List<ProductView> test = List();

  return Tuple2(test, test.length == 0);
}
