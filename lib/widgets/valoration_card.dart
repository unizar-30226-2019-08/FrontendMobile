/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';

/*
  CLASE: ValorationCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ValorationCard extends StatefulWidget {
  final User currentUser; //usuario actual
  final User userToValorate; //usuario a valorar
  ValorationCard({this.currentUser, this.userToValorate});

  _ValorationCardState createState() => _ValorationCardState();
}

class _ValorationCardState extends State<ValorationCard> {
  double rating = 3.0; //valoración proporcionada por las estrellas
  final _formKey = GlobalKey<FormState>();
  _ValorationCardState();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15.0),
                          topRight: const Radius.circular(15.0))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.rate_review,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        Text(
                          Translations.of(context).text("rate_user",
                              params: [widget.userToValorate.getName()]),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),

                //Texto de presentación
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(Translations.of(context).text("valoration_text"),
                      style: TextStyle(height: 1.0, fontSize: 20)),
                ),
                Padding(
                    //Campo que debe ser rellenado obligatoriamene
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 1000, //1000 caracteres máximo
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                          hintText:
                              Translations.of(context).text("how_was_it")),
                      validator: (review) {
                        if (review.length < 15) {
                          //El comentario debe tener al menos 30 caracteres
                          return Translations.of(context)
                              .text("review_too_short");
                        }
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: StarRating(
                    size: 40.0,
                    rating: rating,
                    color: Colors.pink,
                    borderColor: Colors.grey,
                    starCount: 5,
                    onRatingChanged: (rating) => setState(
                          () {
                            this.rating =
                                rating; //la variable "rating" cambia al pulsar las estrellas
                          },
                        ),
                  ),
                ),

                //confirmar y enviar valoración
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.pink, width: 3.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Text(
                          Translations.of(context).text("send"),
                          style: TextStyle(
                              color: Colors.pink[600],
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          //comprobar si la información introducida es válida al pulsar
                          _formKey.currentState.validate();
                        },
                      ),
                      Container(width: 15.0),
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Text(
                          Translations.of(context).text("report"),
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ])),
        ));
  }

  /*
   * Pre:   ---
   * Post:  devuelve true si el estado del formulario es válido
   */
  bool validate() {
    var valid = _formKey.currentState.validate();
    if (valid) _formKey.currentState.save();
    return valid;
  }
}
