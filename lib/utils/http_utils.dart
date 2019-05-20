/*
 * FICHERO:     http_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de respuestas http
 * CREACIÓN:    03/05/2019
 */

import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/objects/filter_query.dart';

import 'dart:convert';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/objects/product.dart';

final Map<String, String> headers = {'appmovil': 'true'};

Future<Tuple2<List<ProductView>, bool>> parseProducts(
    FilterQuery query, int currentSize) async {
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

Future<bool> editProduct(Product product, List<File> images) async {
  var uri = Uri.parse('https://bookalo.es/api/edit_product');
  var request = http.MultipartRequest("POST", uri);
  List<http.MultipartFile> im = [];
  var length = 0;
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  request.fields['token'] = await user.getIdToken();
  //print("token = " + request.fields['token']);
  for (int i = 0; i < images.length; i++) {
    var stream =
        new http.ByteStream(DelegatingStream.typed(images[i].openRead()));
    print("stream imagen " + stream.toString());
    length = await images[i].length();
    im.add(http.MultipartFile('files', stream, length,
        filename: 'imagen' + i.toString()));
  }
  request.files.addAll(im);
  print("num Imagenes entrantes " + images.length.toString());
  print("numImagenes anyadidas " + request.files.length.toString());
  request.fields['id'] = product.getId().toString();
  request.fields['latitud'] = product.getPosition().latitude.toString();
  request.fields['longitud'] = product.getPosition().longitude.toString();
  request.fields['nombre'] = product.getName();
  request.fields['precio'] = product.getPrice().toString();
  request.fields['estado_producto'] = product.getState();
  request.fields['tipo_envio'] = product.isShippingIncluded().toString();
  request.fields['descripcion'] = product.getDescription();
  request.fields['tags'] = product.getTagsToString();
  request.fields['isbn'] = product.getISBN();

  request.headers.addAll(headers);
  print("Enviando");
  var response = await request.send();

  return response.statusCode == 201;
}

Future<bool> uploadNewProduct(Product product, List<File> images) async {
  var uri = Uri.parse('https://bookalo.es/api/create_product');
  var request = http.MultipartRequest("POST", uri);
  List<http.MultipartFile> im = [];
  var length = 0;
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  request.fields['token'] = await user.getIdToken();
  //print("token = " + request.fields['token']);
  for (int i = 0; i < images.length; i++) {
    var stream =
        new http.ByteStream(DelegatingStream.typed(images[i].openRead()));
    print("stream imagen " + stream.toString());
    length = await images[i].length();
    im.add(http.MultipartFile('files', stream, length,
        filename: 'imagen' + i.toString()));
  }
  request.files.addAll(im);
  // print("request Files " + request.fields.toString());
  print("num Imagenes entrantes " + images.length.toString());
  print("numImagenes anyadidas " + request.files.length.toString());
  request.fields['latitud'] = product.getPosition().latitude.toString();
  request.fields['longitud'] = product.getPosition().longitude.toString();
  request.fields['nombre'] = product.getName();
  request.fields['precio'] = product.getPrice().toString();
  request.fields['estado_producto'] = product.getState();
  request.fields['tipo_envio'] = product.isShippingIncluded().toString();
  request.fields['descripcion'] = product.getDescription();
  request.fields['tags'] = product.getTagsToString();
  request.fields['isbn'] = product.getISBN();

  request.headers.addAll(headers);
  print("Enviando");
  var response = await request.send();

  return response.statusCode == 201;
}

Future<List<String>> getInfoISBN(String isbn) async {
  
  Map<String, String> body = {'isbn': isbn};

  var response = await http.get('https://bookalo.es/api/get_info_isbn?isbn=' + isbn,
      headers: headers);

  print("status = " + response.statusCode.toString());
  //print(response.body);
  if (response.statusCode == 200) {
 //   print("mapenado json");
    var libro  = json.decode(utf8.decode(response.bodyBytes));
  //  print(libro['Descripcion']);
    return [libro['Titulo'], libro['Descripcion'],];

   
  }
  return ['',''];
}
