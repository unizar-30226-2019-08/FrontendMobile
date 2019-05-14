/*
 * FICHERO:     http_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de respuestas http
 * CREACIÓN:    03/05/2019
 */

import 'dart:io';

import 'package:async/async.dart';
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



Future<bool> uploadNewProduct(Product product, List<File> images) async {
  var uri = Uri.parse('https://bookalo.es/api/create_product');
  var request = http.MultipartRequest("POST", uri);
  int i = 0;
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  request.fields['token'] = await user.getIdToken();
  images.forEach((f) async{
    var stream = new http.ByteStream(DelegatingStream.typed(f.openRead()));
    var im = http.MultipartFile('files', stream, await stream.length, filename: 'imagen' + i.toString());
    request.files.add(im);
  });
  print("numImagenes" + request.files.length.toString());
  request.fields['latitud'] = product.getPosition().latitude.toString();
  request.fields['longitud'] = product.getPosition().longitude.toString();
  request.fields['nombre'] = product.getName();
  request.fields['precio'] = product.getPrice().toString();
  request.fields['estado_producto'] = product.getState();
  request.fields['tipo_envio'] = product.isShippingIncluded().toString();
  request.fields['descripcion'] = product.getDescription();
  request.fields['tags'] = product.getTagsToString();

  request.headers.addAll(headers);

  var response = await request.send();
  print("Resultado del envio ha sido "  + response.statusCode.toString());
  return response.statusCode == 201;
}
