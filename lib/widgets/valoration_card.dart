/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/report.dart';
import 'package:bookalo/objects/review.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/objects/chats_registry.dart';

/*
  CLASE: ValorationCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ValorationCard extends StatefulWidget {
  final Chat chat;
  ValorationCard({this.chat});

  _ValorationCardState createState() => _ValorationCardState();
}

class _ValorationCardState extends State<ValorationCard> {
  TextEditingController _controller;
  double _rating = 3.0;
  final _formKey = GlobalKey<FormState>();
  _ValorationCardState();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
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
                              params: [widget.chat.getOtherUser.getName()]),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLength: 1000, //1000 caracteres máximo
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                          hintText:
                              Translations.of(context).text("how_was_it")),
                      validator: (review) {
                        if (review.length < 15) {
                          return Translations.of(context)
                              .text("review_too_short");
                        }
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: StarRating(
                    size: 40.0,
                    rating: _rating,
                    color: Colors.pink,
                    borderColor: Colors.grey,
                    starCount: 5,
                    onRatingChanged: (rating) => setState(
                          () {
                            this._rating = rating;
                          },
                        ),
                  ),
                ),
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Review review = Review(
                                widget.chat.getOtherUser,
                                widget.chat.getMe,
                                DateTime.now(),
                                !widget.chat.imBuyer,
                                widget.chat.getProduct,
                                _controller.text,
                                _rating*2);
                            await rateUser(widget.chat, review, seeErrorWith: context);
                            ScopedModel.of<ChatsRegistry>(context).setReview(review, widget.chat.getUID);
                          }
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Report(
                                      userToReport: widget.chat.getOtherUser,
                                    )),
                          );
                        },
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
