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

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/user.dart';


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

Future<List<Tag>> parseTags(List<Tag> initialTags) async {
  List<Tag> tagList = [];
  var response = await http.post('https://bookalo.es/api/get_tags');
  tagList.addAll(initialTags);
  (json.decode(response.body)['tags'] as List).forEach((x) {
    if (!initialTags.map((tag) {
      return tag.title;
    }).contains(x['nombre'])) {
      tagList.add(Tag(title: x['nombre'], active: false));
    }
  });
  return tagList;
}
