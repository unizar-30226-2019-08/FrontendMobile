/*
 *  CLASE:        Review
 *  DESCRIPCIÓN:  contiene la información necesaria para
 *                generar y construir una valoración
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: 'usuario_que_valora') // usuario que realiza la vaoracion
  User user;
  @JsonKey(name: 'timestamp') //momento de la valoración
  DateTime date;
  bool isSeller;
  @JsonKey(name: 'producto') //producto vendido/comprado por usuario valorado
  Product product;
  @JsonKey(name: 'comentario')//comentario
  String review;
  @JsonKey(name: 'estrellas')//valoración en formato estrellas
  double stars;

  Review(this.user, this.date, this.isSeller, this.product, this.review,
      this.stars);

  void setIsSeller(bool isSeller) {
    this.isSeller = isSeller;
  }

  User get getUser => user;
  DateTime get getDate => date;
  bool get checkIsSeller => isSeller;
  Product get getProduct => product;
  String get getReview => review;
  double get getStarts => stars;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
