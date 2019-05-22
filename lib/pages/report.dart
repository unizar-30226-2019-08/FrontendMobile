/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';

/*
  CLASE: ValorationCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class Report extends StatefulWidget {
  final User userToReport; //usuario a valorar
  Report({ this.userToReport});
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
        appBar: SimpleNavbar(title: Translations.of(context).text("report_title"), iconData: Icons.flag, preferredSize: Size.fromHeight(height / 10)),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(Translations.of(context).text("report_text", params: [widget.userToReport.getFirstName()]),
                          style: TextStyle(height: 1.0, fontSize: 20)),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Icon(Icons.receipt, size: 40)
                        ),
                        Text(
                          Translations.of(context).text("what_happened"),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: height / 4,
                          child: ListView(children: [
                             Row(children: [
                               Radio(
                                value: _value1,
                                onChanged: (_value1) => _valueChanged(_value1),
                                activeColor: Colors.pink,
                                groupValue: groupValue,
                              ),
                               Text(Translations.of(context).text("fraud")),
                            ]),
                             Row(children: [
                               Radio(
                                value: _value2,
                                onChanged: (_value2) => _valueChanged(_value2),
                                activeColor: Colors.pink,
                                groupValue: groupValue,
                              ),
                               Text(Translations.of(context)
                                  .text("offensive_comment")),
                            ]),
                             Row(children: [
                               Radio(
                                value: _value3,
                                onChanged: (_value3) => _valueChanged(_value3),
                                activeColor: Colors.pink,
                                groupValue: groupValue,
                              ),
                               Text(Translations.of(context)
                                  .text("offensive_content")),
                            ]),
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLength: 1000, //1000 caracteres máximo
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
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
