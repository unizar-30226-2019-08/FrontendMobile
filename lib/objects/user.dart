/*
 * FICHERO:     user.dart
 * DESCRIPCIÓN: clase User
 * CREACIÓN:    15/03/2019
 */

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bookalo/utils/dates_utils.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'nombre')
  String displayName;
  @JsonKey(name: 'imagen_perfil')
  String pictureURL;
  @JsonKey(name: 'uid')
  String uid;
  @JsonKey(name: 'ciudad')
  String city;
  @JsonKey(name: 'media_valoraciones')
  double rating;
  @JsonKey(name: 'numValoraciones')
  int ratingsAmount;
  @JsonKey(name: 'ultima_conexion')
  DateTime lastConnection;

  /*
   *  SOLO SE USA EN SERIALIZACIÓN
   */

  User(this.displayName, this.pictureURL, this.uid, this.city, this.rating,
      this.ratingsAmount, this.lastConnection);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /*
   * Pre:   ---
   * Post:  ha devuelto el nombre anonimizado del usuario, p.e Juan.L o Juan
   */
  String getName() {
    var displayName = this.displayName.split(" ");
    if (displayName.length > 1) {
      return displayName[0] + ' ' + displayName[1][0] + '.';
    } else {
      return displayName[0];
    }
  }

  String getFirstName() {
    var displayName = this.displayName.split(" ");
    return displayName[0];
  }

  /*
   * Pre:   ---
   * Post:  ha devuelto el URL de la foto de perfil del usuario
   */
  String getPicture() {
    return this.pictureURL;
  }

  /*
   * Pre:   ---
   * Post:  ha devuelto el identificador único del usuario
   */
  String getUID() {
    return this.uid;
  }

  /* 
   * Pre:   ---
   * Post:  ha devuelto el nombre de la ciudad del usuario
   */
  String getCity() {
    return this.city;
  }

  /*
   * Pre:   ---
   * Post:  ha devuelto la calificación promedio del usuario
   */
  double getRating() {
    return this.rating;
  }

  /*
   * Pre:   ---
   * Post:  ha devuelto el número de calificaciones del usuario
   */
  int getRatingsAmount() {
    return this.ratingsAmount;
  }

  /*
   * Pre:   ---
   * Post:  ha devuelto  true si el usuario se ha conectado durante los últimos 5 minutos
   */
  bool isOnline() {
    return this
        .lastConnection
        .isAfter(DateTime.now().subtract(Duration(minutes: 5)));
  }

  String getLastConnection(BuildContext context) {
    return dateToFullString(this.lastConnection, context);
  }
}
