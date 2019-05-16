/*
 * FICHERO:     upload_title.dart
 * DESCRIPCIÓN: clases relativas a la nombre, descripcion y titulo de un usuario
 * CREACIÓN:    12/05/2019
 */

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
enum ConfirmAction { CANCEL, ACCEPT }
/*
 *  CLASE:        UploadTitle
 *  TODO: Widget sin implementar
 *  DESCRIPCIÓN:  
 */

class UploadTitle extends StatefulWidget {
  final Function(String) isbnInserted;
  final Function(String) tittleInserted;
  final Function(String) descriptionInserted;
  final Function(String) stateProductInserted;
	final Function(double) priceInserted;
  final Function(bool) includeSend;
  final Function(bool) valitedPage;
  final formKey;
  final Product prod;
  const UploadTitle(
      {Key key,
      this.isbnInserted,
      this.tittleInserted,
      this.descriptionInserted,
      this.prod,
      this.formKey,
      this.valitedPage,
      this.stateProductInserted,
      this.includeSend, this.priceInserted})
      : super(key: key);
  @override
  _UploadTitleState createState() => _UploadTitleState();
}

class _UploadTitleState extends State<UploadTitle> {
  String _isbn = "";
	
  String _value1 = "Nuevo";
  String _value2 = "Seminuevo";
  String _value3 = "Usado";

  String groupValue;

  String _sinEnvio = "Sin envio";
  String _conEnvio = "Con envio";
  bool titleIni = false,
      descIni =
          false; //Indica si se ha iniciado o no el titulo/descIni respectivamente
  bool validatePage = false,
      titleValited = false,
      isbnValited = false,
      descValited = false;

  var controller;

  void _valueChanged(String value) =>
      setState(() => widget.prod.setState(value));
  void _valueSendChanged(String value) =>
      setState(() => widget.prod.setShippingIncluded(value == _conEnvio));

  @override
  void initState() {
    super.initState();
		controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', rightSymbol: '€',initialValue: widget.prod.getPrice());
//			this._valueChanged(widget.prod.getState());
  }

  Future barcodeScanning() async {
//imageSelectorGallery();

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        _isbn = barcode;
        widget.isbnInserted(barcode);
        widget.formKey.currentState.validate();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._isbn = Translations.of(context).text("no_camera_persission");
        });
      } else {
        setState(() => this._isbn = Translations.of(context).text("unknow_error",params: [e.toString()]));
      }
    } on FormatException {
      setState(() => this._isbn = Translations.of(context).text('nothing_caputured'));
    } catch (e) {
      setState(() => this._isbn = Translations.of(context).text("unknow_error",params: [e.toString()]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
      children: <Widget>[
        Form(
            key: widget.formKey,
            onChanged: () {
              setState(() {
                validatePage = widget.formKey.currentState.validate() &&
                    titleIni &&
                    descIni;
                if (validatePage) {
                  widget.formKey.currentState.save();
                }
                //	widget.stateProductInserted(groupValue);
                widget.valitedPage(validatePage);
              });
            },
            child: Column(children: <Widget>[
              OutlineButton(
                borderSide: BorderSide(color: Colors.pink, width: 3.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Text(
                  Translations.of(context).text("isbn_scan"),
                  style: TextStyle(
                      color: Colors.pink[600], fontWeight: FontWeight.w700),
                ),
                //onPressed: barcodeScanning,
                onPressed: barcodeScanning,
              ),
              TextFormField(
                //Input ISBN
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 13, //13 numeros máximo
                maxLengthEnforced: true,
                initialValue: widget.prod.getISBN(),
                onSaved: (String isbnReaded) {
                  setState(() {
                    widget.isbnInserted(isbnReaded);
                  });
                },
                decoration: InputDecoration(
                    hintText: Translations.of(context).text("isbn_hint")),
                validator: (isbn) {
                  if (isbn.isNotEmpty && isbn.length < 13) {
                    //El ISBN ha de contener 13 dígitos
                    return Translations.of(context).text("isbn_too_short");
                  }
                },
              ),
              TextFormField(
                // Input titulo
                keyboardType: TextInputType.text,
                maxLines: 1,
                maxLength: 50, //1000 caracteres máximo
                maxLengthEnforced: true,
                initialValue: widget.prod.getName(),
                onSaved: (String value) {
                  setState(() {
                    widget.tittleInserted(value);
                  });
                },
                decoration: InputDecoration(
                    hintText: Translations.of(context).text("title_hint")),
                validator: (title) {
                  if (title.length > 0) {
                    titleIni = true;
                  }
                  if (titleIni && title.length < 2) {
                    //El nombre de articulo debe tener al menos 2 caracteres
                    return Translations.of(context).text("title_too_short");
                  }
                },
              ),
              TextFormField(
                //Input Descripcion
                keyboardType: TextInputType.text,
                maxLines: 4,
                maxLength: 1000, //1000 caracteres máximo
                maxLengthEnforced: true,
                onSaved: (String value) {
                  widget.descriptionInserted(value);
                },
                initialValue: widget.prod.getDescription(),
                decoration: InputDecoration(
                    hintText:
                        Translations.of(context).text("description_hint")),
                validator: (description) {
                  if (description.length > 0) {
                    descIni = true;
                  }
                  if (descIni && description.length < 2) {
                    //El comentario debe tener al menos 30 caracteres
                    return Translations.of(context)
                        .text("description_too_short");
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).text("state")),
                  Row(children: [
                    Text(Translations.of(context).text("New"),
                        style: TextStyle(fontSize: 10)),
                    Radio(
                      value: _value1,
                      onChanged: (_value1) => changeState(_value1),
                      activeColor: Colors.pink,
                      groupValue: widget.prod.getState(),
                    ),
                    Text(Translations.of(context).text("Almost-New"),
                        style: TextStyle(fontSize: 10)),
                    Radio(
                      value: _value2,
                      onChanged: (_value2) => changeState(_value2),
                      activeColor: Colors.pink,
                      groupValue: widget.prod.getState(),
                    ),
                    Text(Translations.of(context).text("Old"),
                        style: TextStyle(fontSize: 10)),
                    Radio(
                      value: _value3,
                      onChanged: (_value3) => changeState(_value3),
                      activeColor: Colors.pink,
                      groupValue: widget.prod.getState(),
                    ),
                  ]),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(),
                    Text(Translations.of(context).text("tipo_envio")),
                    Row(children: [
                      Text(Translations.of(context).text("con_envio"),
                          style: TextStyle(fontSize: 10)),
                      Radio(
                        value: _conEnvio,
                        onChanged: (_conEnvio) => changeSend(_conEnvio),
                        activeColor: Colors.pink,
                        groupValue: widget.prod.getStringShippinIncluded(),
                      ),
                      Text(
                          Translations.of(context).text("sin_envio"),
                          style: TextStyle(fontSize: 10)),
                      Radio(
                          value: _sinEnvio,
                          onChanged: (_sinEnvio) => changeSend(_sinEnvio),
                          activeColor: Colors.pink,
                          groupValue: widget.prod.getStringShippinIncluded()),
                    ]),
                  ]),
									Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).text("price")),
                  TextField(
										cursorWidth: 0,
                    controller: controller,
                    keyboardType: TextInputType.number,
										onChanged: (value) {
										//	print(controller.toString());
											setState(() {
											//	print("leido " + controller.numberValue.toString());
											//	print("precio anyadir es " + (double.parse(value.substring(0,value.length-1))*10).toString());
												widget.priceInserted(controller.numberValue);
												
										});},
                  )
                ],
              )
            ])),
      ],
    );
  }

 

  void changeState(String newState) {
    widget.stateProductInserted(newState);
    _valueChanged(newState);
  }

  void changeSend(String newState) {
    // widget.includeSend(newState == _conEnvio);
    _valueSendChanged(newState);
  }
}
