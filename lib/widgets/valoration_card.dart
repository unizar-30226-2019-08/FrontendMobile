import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';

class ValorationCard extends StatefulWidget {
  final User currentUser;
  final User userToValorate;
  ValorationCard({this.currentUser, this.userToValorate});

  _ValorationCardState createState() => _ValorationCardState();
}

class _ValorationCardState extends State<ValorationCard> {
  double rating = 3.0;
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
                            size: 30.0,),
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
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(Translations.of(context).text("valoration_text"),
                      style: TextStyle(height: 1.0, fontSize: 20)),
                ),
                Padding(
                    //Campo que debe ser reelenado obligatoriamene
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      maxLength: 1000,
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text("how_was_it")
                      ),
                      validator: (review) {
                        if (review.length < 30) {
                          return Translations.of(context).text("review_too_short");
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
                            this.rating = rating;
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        child: Text(
                          Translations.of(context).text("send"),
                          style: TextStyle(
                            color: Colors.pink[600],
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        onPressed: (){
                          _formKey.currentState.validate();
                        },
                      ),
                      Container(width: 15.0),
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        child: Text(
                          Translations.of(context).text("report"),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        onPressed: (){},
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
