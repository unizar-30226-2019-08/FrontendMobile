/*
 * FICHERO:     objects_generator.dart
 * DESCRIPCIÓN: funciones de generación de objetos de mockup
 * CREACIÓN:    18/04/2019
 */

import 'dart:math';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';

/*
 * Pre:   firebaseUser es un usuario de Firebase válido
 * Post:  ha devuelto un objeto User basado en firebaseUser
 */
User generatePseudoUser(FirebaseUser firebaseUser) {
  return User(
      firebaseUser.displayName,
      firebaseUser.photoUrl,
      firebaseUser.uid,
      faker.address.city(),
      Random().nextDouble() * 10,
      Random().nextInt(100),
      Random().nextDouble() > 0.5,
      false);
}

/*
 * Pre:   ---
 * Post:  ha devuelto un objeto User aleatorio
 */
User generateRandomUser() {
  var faker = new Faker();
  return User(
      faker.person.firstName() + ' ' + faker.person.lastName()[0],
      "https://picsum.photos/300/?random",
      "123abc",
      faker.address.city(),
      Random().nextDouble() * 10,
      Random().nextInt(100),
      Random().nextDouble() > 0.5,
      false);
}

/*
 *Pre: Option tiene valores entre 1 y 6
 *Post:Elige uno de los estados según el parametro
 */

String randomState(int option){
  switch (option){
  case 1:return "Nuevo";
  break;

  case 2:return "Semi-Nuevo";
  break;

  case 3: return "Antigüedad";
  break;

  case 4: return "Usado";
  break;

  case 5: return "Roto";
  break;

  default: return "Desgastado";
  break;
}
}




/*
 * Pre:   ---
 * Post:  ha devuelto un objeto Product aleatorio
 */
Product generateRandomProduct() {
  return Product(
      faker.company.name(),
      (Random().nextDouble() * 30).round().toDouble(),
      Random().nextDouble() > 0.8,
      "https://picsum.photos/200/300/?random",
      lipsum.createSentence(), Random().nextDouble() > 0.5,randomState(Random().nextInt(6)),Random().nextInt(1000));
}
