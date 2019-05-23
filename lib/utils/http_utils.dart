/*
 * FICHERO:     http_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de respuestas http
 * CREACIÓN:    03/05/2019
 */

import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:bookalo/objects/message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/review.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/review.dart';
import 'package:bookalo/objects/chats_registry.dart';

final Map<String, String> headers = {'appmovil': 'true'};

Future<List<Widget>> parseProducts(
    FilterQuery query, int currentIndex, int pageSize) async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await currentUser.getIdToken(),
    'tags': query.tags,
    'busqueda': query.querySearch,
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

Future<List<Product>> parseOwnProducts(int currentIndex, int pageSize) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'uid': user.uid,
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_user_products',
      headers: headers, body: body);
  List<Product> output = List();
  (json.decode(utf8.decode(response.bodyBytes))['productos'] as List)
      .forEach((x) {
    output.add(Product.fromJson(x['info_producto']));
  });
  return output;
}

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

void registerFavorite(Product product) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await user.getIdToken(),
    'idProducto': product.getId().toString()
  };
  await http.post('https://bookalo.es/api/like_product',
      headers: headers, body: body);
}

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

Future<Chat> createChat(
    User user, Product product, BuildContext context) async {
  Chat chat =
      ScopedModel.of<ChatsRegistry>(context).getSellersChat.singleWhere((c) {
    return c.getOtherUser.getUID() == user.getUID() &&
        c.getProduct.getId() == product.getId();
  }, orElse: () {
    return null;
  });
  if (chat == null) {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    Map<String, String> body = {
      'token': await firebaseUser.getIdToken(),
      'uidUsuario': user.getUID(),
      'idProducto': product.getId().toString()
    };
    var response = await http.post('https://bookalo.es/api/create_chat',
        headers: headers, body: body);
    chat = Chat.fromJson(
        json.decode(utf8.decode(response.bodyBytes))['chat_cargado']);
    chat.setImBuyer(true);
    ScopedModel.of<ChatsRegistry>(context).addChats('sellers', [chat]);
  }
  return chat;
}

Future<List<Chat>> parseChats(
    bool imBuyer, int currentIndex, int pageSize) async {
  List<Chat> output = [];
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'tipo_chats': (imBuyer ? 'compra' : 'venta'),
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_chats',
      headers: headers, body: body);
  (json.decode(utf8.decode(response.bodyBytes))['chats'] as List).forEach((x) {
    Chat newChat = Chat.fromJson(x);
    newChat.setImBuyer(imBuyer);
    output.add(newChat);
  });
  return output;
}

Future<List<Message>> parseMessages(
    int chatUID, int currentIndex, int pageSize) async {
  List<Message> output = [];
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'id_chat': chatUID.toString(),
    'ultimo_indice': currentIndex.toString(),
    'elementos_pagina': pageSize.toString()
  };
  var response = await http.post('https://bookalo.es/api/get_messages',
      headers: headers, body: body);
  (json.decode(utf8.decode(response.bodyBytes))['mensajes'] as List)
      .forEach((x) {
    Message newMessage = Message.fromJson(x);
    output.add(newMessage);
  });
  return output;
}

Future<bool> sendMessage(int chatUID, String message) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'token_fcm' : await _firebaseMessaging.getToken(),
    'id_chat': chatUID.toString(),
    'mensaje': message
  };
  var response = await http.post('https://bookalo.es/api/send_message',
      headers: headers, body: body);
  return response.statusCode == 200;
}

Future<bool> deleteProduct(int productUID) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'idProducto': productUID.toString(),
  };
  var response = await http.post('https://bookalo.es/api/delete_product',
      headers: headers, body: body);
  return response.statusCode == 200;
}

Future<bool> markAsSold(int chatUID) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'id_chat': chatUID.toString(),
  };
  var response = await http.post('https://bookalo.es/api/sell_product',
      headers: headers, body: body);
  return response.statusCode == 200;
}

Future<void> logout() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Map<String, String> body = {
    'fcm_token': await _firebaseMessaging.getToken(),
  };
  await http.post('https://bookalo.es/logout', headers: headers, body: body);
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
  request.fields['id_producto'] = product.getId().toString();
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
  var response = await request.send();
  return response.statusCode == 200;
}

Future<bool> uploadNewProduct(Product product, List<File> images) async {
  var uri = Uri.parse('https://bookalo.es/api/create_product');
  var request = http.MultipartRequest("POST", uri);
  List<http.MultipartFile> im = [];
  var length = 0;
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  request.fields['token'] = await user.getIdToken();
  for (int i = 0; i < images.length; i++) {
    var stream =
        new http.ByteStream(DelegatingStream.typed(images[i].openRead()));
    length = await images[i].length();
    im.add(http.MultipartFile('files', stream, length,
        filename: 'imagen' + i.toString()));
  }
  request.files.addAll(im);
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
  var response = await request.send();

  return response.statusCode == 201;
}

Future<List<String>> getInfoISBN(String isbn) async {
  var response = await http.get(
      'https://bookalo.es/api/get_info_isbn?isbn=' + isbn,
      headers: headers);

  if (response.statusCode == 200) {
    var libro = json.decode(utf8.decode(response.bodyBytes));
    return [
      libro['Titulo'],
      libro['Descripcion'],
    ];
  }
  return ['', ''];
}

Future<bool> rateUser(Chat chat, Review review) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  Map<String, String> body = {
    'token': await firebaseUser.getIdToken(),
    'estrellas': review.getStars.toInt().toString(),
    'comentario' : review.getReview,
    'uid_usuario_valorado' : chat.getOtherUser.getUID(),
    'id_producto_valorado' : chat.getProduct.getId().toString()
  };
  var response = await http.post(
      'https://bookalo.es/api/rate_user',
      headers: headers, body: body);
  return response.statusCode == 200;
}