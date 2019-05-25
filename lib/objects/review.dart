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
  @JsonKey(name: 'usuario_que_valora')
  User reviewer;
  @JsonKey(name: 'timestamp')
  DateTime date;
  bool isSeller;
  @JsonKey(name: 'producto')
  Product product;
  @JsonKey(name: 'comentario')
  String review;
  @JsonKey(name: 'estrellas')
  double stars;
  User ratedUser;

  Review(this.ratedUser, this.reviewer, this.date, this.isSeller, this.product,
      this.review, this.stars);

  void setIsSeller(bool isSeller) {
    this.isSeller = isSeller;
  }

  User get getReviewer => reviewer;
  User get getRatedUSer => ratedUser;
  DateTime get getDate => date;
  bool get checkIsSeller => isSeller;
  Product get getProduct => product;
  String get getReview => review;
  double get getStars => stars;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
