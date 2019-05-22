/*
 * FICHERO:     http_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de respuestas http
 * CREACIÓN:    03/05/2019
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/review.dart';

final Map<String, String> headers = {'appmovil': 'true'};

//MOSTRAR PRODUCTOS A COMPRAR PRODUCTOS
Future<List<Widget>> parseProducts(
    FilterQuery query, int currentIndex, int pageSize) async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await currentUser.getIdToken(),
    'tags': query.tags,
    'busqueda': '',
    'precio_minimo': query.usesMinPrice ? query.minPrice.toString() : '0',
    'precio_maximo': query.usesMaxPrice ? query.maxPrice.toString() : '',
    'calificacion_minima': query.usesRating ? query.minRating.toString() : '',
    'distancia_maxima': query.usesDistance ? query.maxDistance.toString() : '',
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString(),
    'latitud': query.position.latitude == 0.0
        ? ''
        : query.position.latitude.toString(),
    'longitud': query.position.longitude == 0.0
        ? ''
        : query.position.longitude.toString(),
  };

  var response = await http.post('https://bookalo.es/api/filter_product',
      headers: headers, body: body);
  List<Widget> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos'] as List)
      .forEach((x) {
    Product product = Product.fromJson(x['info_producto']);
    User user = User.fromJson(x['vendido_por']);
    output.add(ProductView(
        product, user, user.getUID() == currentUser.uid, x['le_gusta']));
  });

  return output;
}



//MOSTRAR TAGS
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



//MOSTRAR LOS PRODUCTOS PROPIOS
Future<List<MiniProduct>> parseOwnProducts(
    int currentIndex, int pageSize) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'uid': user.uid,
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_user_products',
      headers: headers, body: body);
  List<MiniProduct> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos'] as List)
      .forEach((x) {
    Product product = Product.fromJson(x['info_producto']);
    output.add(MiniProduct(product));
  });
  return output;
}



//MOSTRAR LOS PRODUCTOS DE UN USUARIO
Future<List<ProductView>> parseUserProducts(
    User productOwner, int currentIndex, int pageSize) async {
  Map<String, String> body = {
    'uid': productOwner.getUID(),
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_user_products',
      headers: headers, body: body);
  List<ProductView> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos'] as List)
      .forEach((x) {
    Product product = Product.fromJson(x['info_producto']);
    output.add(ProductView(product, productOwner, false, x['le_gusta']));
  });
  return output;
}



//MOSTRAR LOS FAVORITOS DE UN USUARIO
Future<List<ProductView>> parseUserFavorites(
    int currentIndex, int pageSize) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await user.getIdToken(),
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_favorites',
      headers: headers, body: body);
  List<ProductView> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos_favoritos'] as List)
      .forEach((x) {
    Product product = Product.fromJson(x['info_producto']);
    User owner = User.fromJson(x['vendido_por']);
    output.add(ProductView(product, owner, false, true));
  });
  return output;
}



//FUNCION PARA MARCAR UN PRODUCTO COMO FAVORITO
void registerFavorite(Product product) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await user.getIdToken(),
    'idProducto': product.getId().toString()
  };
  await http.post('https://bookalo.es/api/like_product',
      headers: headers, body: body);
}





//MOSTRAR PERFIL PROPIO
Future<User> fetchOwnProfile() async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'uid': firebaseUser.uid
  };
  var response = await http.post('https://bookalo.es/api/get_user_info',
      headers: headers, body: body);
  User user = User.fromJson(
      json.decode(utf8.decode(response.bodyBytes))['informacion_basica']);
  return user;
}




//MOSTRAR VALORACIONES
Future<List<ReviewCard>> parseReviews(int currentIndex, int pageSize,
    {User user}) async {
  String uid;
  List<ReviewCard> output = [];
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  if (user == null) {
    uid = firebaseUser.uid;
  } else {
    uid = user.uid;
  }
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'uid': uid,
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_ratings',
      headers: headers, body: body);
  (json.decode(utf8.decode(response.bodyBytes))['valoraciones'] as List)
      .forEach((x) {
    output.add(ReviewCard(review: Review.fromJson(x)));
  });
  return output;
}
