/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/navbars/report_navbar.dart';

/*
  CLASE: ValorationCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class Report extends StatefulWidget {
  final User currentUser; //usuario actual
  final User userToValorate; //usuario a valorar
  Report({this.currentUser, this.userToValorate});

  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  double rating = 3.0; //valoración proporcionada por las estrellas
  final _formKey = GlobalKey<FormState>();
    bool _value1 = false;
  bool _value2 = false;
    bool _value3 = false;

  _ReportState();
void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);


  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: ReportNavbar(preferredSize: Size.fromHeight(height / 10)),
        body:  Padding(
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
                          "QUE HA PACHAO",
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
                  child: Text("¡Vaya! Sentimos lo ocurrido.Por favor, expón el motivo de esta desagradable noticia",
                      style: TextStyle(height: 1.0, fontSize: 20)),
                ),
                 Padding(
                    //Campo que debe ser rellenado obligatoriamene
                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child:
                  Container(
                    height:height/4,
                    child:
                    ListView(children:[
                          new CheckboxListTile(
                  value: _value1,
                  onChanged: _value1Changed,
                  title: new Text('Racismo'),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.pink,
                          ),
              new CheckboxListTile(
                  value: _value2,
                  onChanged: _value2Changed,
                  title: new Text('Abuso'),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.pink,
              ),
              new CheckboxListTile(
                  value: _value3,
                  onChanged: _value3Changed,
                  title: new Text('Maltrato'),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.pink,
              )
                  ]
              ),
                  )     
                 ),
                Padding(
                    //Campo que debe ser rellenado obligatoriamene
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:10),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 1000, //1000 caracteres máximo
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                          hintText:
                              Translations.of(context).text("how_was_it")),
                      validator: (review) {
                        if (review.length < 30) {
                          //El comentario debe tener al menos 30 caracteres
                          return Translations.of(context)
                              .text("review_too_short");
                        }
                      },
                    )
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
                     
                    ],
                  ),
                )
              ])),
        ))
            );
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
