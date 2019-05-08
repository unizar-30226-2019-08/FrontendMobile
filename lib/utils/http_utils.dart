/*
 * FICHERO:     http_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de respuestas http
 * CREACIÓN:    03/05/2019
 */

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

Future<List<ProductView>> parseProducts(
    FilterQuery query, int currentIndex, int pageSize) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await user.getIdToken(),
    'tags': query.tags,
    'busqueda': '',
    'precio_minimo': '0.0',
    'precio_maximo': '100.0',
    'calificacion_minima': '-1',
    'latitud': '41.0',
    'longitud': '1.0',
    'distancia_maxima': '-1',
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/filter_product',
      headers: headers, body: body);
  List<ProductView> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos'] as List)
      .forEach((x) {
    Product product = Product.fromJson(x['info_producto']);
    User user = User.fromJson(x['vendido_por']);
    output.add(ProductView(product, user));
  });

  return output;
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

Future<List<MiniProduct>> parseOwnProducts(int currentIndex, int pageSize) async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await user.getIdToken(),
    'uid' : user.uid,
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/filter_product',
      headers: headers, body: body);
  List<MiniProduct> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos'] as List)
      .forEach((x) {
    Product product = Product.fromJson(x['info_producto']);
    output.add(MiniProduct(product));
  });

  return output;
}
