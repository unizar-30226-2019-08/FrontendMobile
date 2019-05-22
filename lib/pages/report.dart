/*
 * FICHERO:     report.dart
 * DESCRIPCIÓN: Clase relativa a la pantalla de reporte
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/navbars/report_navbar.dart';

/*
 * CLASE: Report
 *DESCRIPCIÓN: widget de reporte de un usuario.Requiere un comentario textual y 
 *              valoración mediante estrellas
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
  int _value1 = 1;
  int _value2 = 2;
  int _value3 = 3;
  int groupValue;

  _ReportState();
  void _valueChanged(int value) => setState(() => groupValue = value);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: ReportNavbar(preferredSize: Size.fromHeight(height / 10)),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.rate_review,
                                size: 30.0,
                              ),
                            ),
                            Text(
                              Translations.of(context).text("report_title"),
                              style: TextStyle(
                                  // color: Colors.white,
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
                      child: Text(Translations.of(context).text("report_text"),
                          style: TextStyle(height: 1.0, fontSize: 20)),
                    ),
                    Padding(
                        //Campo que debe ser rellenado obligatoriamene
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: height / 4,
                          child: ListView(children: [
                            new Row(children: [
                              new Radio(
                                value: _value1,
                                onChanged: (_value1) => _valueChanged(_value1),
                                activeColor: Colors.pink,
                                groupValue: groupValue,
                              ),
                              new Text(Translations.of(context).text("fraud")),
                            ]),
                            new Row(children: [
                              new Radio(
                                value: _value2,
                                onChanged: (_value2) => _valueChanged(_value2),
                                activeColor: Colors.pink,
                                groupValue: groupValue,
                              ),
                              new Text(Translations.of(context)
                                  .text("offensive_comment")),
                            ]),
                            new Row(children: [
                              new Radio(
                                value: _value3,
                                onChanged: (_value3) => _valueChanged(_value3),
                                activeColor: Colors.pink,
                                groupValue: groupValue,
                              ),
                              new Text(Translations.of(context)
                                  .text("offensive_content")),
                            ]),
                          ]),
                        )),
                    Padding(
                        //Campo que debe ser rellenado obligatoriamene
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 1000, //1000 caracteres máximo
                          maxLengthEnforced: true,

                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(0.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green

                              hintText: Translations.of(context)
                                  .text("report_comment")),

                          validator: (review) {
                            if (review.length < 30) {
                              //El comentario debe tener al menos 30 caracteres
                              return Translations.of(context)
                                  .text("review_too_short");
                            }
                          },
                        )),

                    //confirmar y enviar valoración
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlineButton(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 3.0),
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
            ])));
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
