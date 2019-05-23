/*
 * FICHERO:     upload_title.dart
 * DESCRIPCIÓN: clases relativas a la nombre, precio, tipo de envío y estado de un producto
 * CREACIÓN:    12/05/2019
 */

import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';
import 'package:validators/validators.dart';

/*
 *  CLASE:        UploadTitle
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
  final Product prod;
  
  const UploadTitle(
      {Key key,
      this.isbnInserted,
      this.tittleInserted,
      this.descriptionInserted,
      this.prod,
      this.valitedPage,
      this.stateProductInserted,
      this.includeSend,
      this.priceInserted,
      })
      : super(key: key);
  @override
  _UploadTitleState createState() => _UploadTitleState();
}

class _UploadTitleState extends State<UploadTitle> {
  String _isbn = "";
  String _value1 = "Nuevo";
  String _value2 = "Seminuevo";
  String _value3 = "Usado";
  var formKey = GlobalKey<FormState>();
  String groupValue;

  String _sinEnvio = "Sin envio";
  String _conEnvio = "Con envio";
  bool titleIni = false,
      priceIni = false,
      descIni =
          false; //Indica si se ha iniciado o no el titulo/descIni respectivamente
  bool validatePage = false,
      titleValited = false,
      isbnValited = false,
      precioValidet = true,
      descValited = false;

  var controllerPrice;
  var controlerISBN;
  var controlerTitle;

  void _valueChanged(String value) =>
      setState(() => widget.prod.setState(value));
  void _valueSendChanged(String value) =>
      setState(() => widget.prod.setShippingIncluded(value == _conEnvio));

  @override
  void initState() {
    super.initState();
    controllerPrice = new MoneyMaskedTextController(
        precision: 1,
        decimalSeparator: '.',
        thousandSeparator: ',',
        rightSymbol: '€',
        initialValue: widget.prod.getPrice());
    if (widget.prod.getISBN().length > 0) {
      controlerISBN = TextEditingController(text: widget.prod.getISBN());
    } else {
      controlerISBN = TextEditingController();
    }

    if (widget.prod.getName().length > 0) {
      controlerTitle = TextEditingController(text: widget.prod.getName());
    } else {
      controlerTitle = TextEditingController();
    }
    titleIni = widget.prod.getName().length > 1;
    priceIni = widget.prod.getPrice() > 0.0;
  }

  Future barcodeScanning() async {

    try {
      String barcode = await BarcodeScanner.scan();
      if (isISBN(barcode, barcode.length)) {
        gettingISBN(context, barcode);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._isbn = Translations.of(context).text("no_camera_persission");
        });
      } else {
        setState(() => this._isbn = Translations.of(context)
            .text("unknow_error", params: [e.toString()]));
      }
    } on FormatException {
      setState(() =>
          this._isbn = Translations.of(context).text('nothing_caputured'));
    } catch (e) {
      setState(() => this._isbn = Translations.of(context)
          .text("unknow_error", params: [e.toString()]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
        children: <Widget>[
          Form(
              autovalidate: true,
              key: formKey,
              onChanged: () {
                formKey.currentState.save();
                setState(() {
                  validatePage = formKey.currentState.validate() &&
                      titleIni &&
                      priceIni;
                  widget.valitedPage(validatePage);
                });
              },
              child: Column(children: <Widget>[
                OutlineButton(
                  borderSide: BorderSide(color: Colors.pink, width: 3.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Translations.of(context).text("isbn_scan"),
                        style: TextStyle(
                            color: Colors.pink[600], fontWeight: FontWeight.w700),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(MdiIcons.barcodeScan, color: Colors.pink, size: 30,)
                      )
                    ],
                  ),
                  onPressed: barcodeScanning,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controlerISBN,
                  maxLines: 1,
                  maxLength: 13, //13 numeros máximo
                  maxLengthEnforced: true,
                  onEditingComplete: () {
                    if (isISBN(controlerISBN.text, controlerISBN.text.length)) {
                      gettingISBN(context, controlerISBN.text);
                    }
                  },
                  onSaved: (String isbnReaded) {
                    setState(() {
                      widget.isbnInserted(controlerISBN.text);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: Translations.of(context).text("isbn_hint")),
                  validator: (isbn) {
                    if (isbn.isNotEmpty) {
                      if (isbn.length < 10) {
                        //El ISBN ha de contener 13 dígitos
                        return Translations.of(context).text("isbn_too_short");
                      }
                      if (!(isISBN(
                          controlerISBN.text, controlerISBN.text.length))) {
                        return Translations.of(context).text("isbn_not_valid");
                      }
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: controlerTitle,
                  maxLines: 1,
                  maxLength: 25,
                  maxLengthEnforced: true,
                  onSaved: (String value) {
                    setState(() {
                      widget.tittleInserted(controlerTitle.text);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: Translations.of(context).text("title_hint")),
                  validator: (title) {
                    if (title.length > 0) {
                      titleIni = true;
                    }
                    if (titleIni &&
                        title.length < 1) {
                      //El nombre de articulo debe tener al menos 2 caracteres
                      return Translations.of(context).text("title_too_short");
                    }
                  },
                ),
                Row(
                  children: <Widget>[
                    //Fila para precio
                    Text(Translations.of(context).text("price") + ": ",
                        style: TextStyle(color: Colors.grey[600])),
                    Container(
                      //El tamaño del textFormField variará dependiendo del cardinal de digitos insertados
                      padding: EdgeInsets.only(left: 10),
                      width: (precioValidet)
                          ? (controllerPrice.text.length) * 10.0
                          : Translations.of(context)
                                  .text("description_hint")
                                  .length *
                              8.0,
                      //SI se desea hacer que ocupe el máximo de la pantalla, cambiar linea anterior por la siguiente
                      //  width: MediaQuery.of(context).size.width - (2+(Translations.of(context).text("price").length)*15),
                      child: TextFormField(
                        //Precio
                        maxLines: 1,
                        validator: (value) {
                          if (controllerPrice.numberValue > 0.0) {
                            //Si precio superior a 0€, no hacer nada
                            //Afecta al tamaño del precio
                            precioValidet = true;
                            priceIni = true;
                          }
                          if (!(controllerPrice.numberValue > 0.0)) {
                            //Afecta al tamaño del precio
                            precioValidet = false;

                            return Translations.of(context)
                                .text("inserte_precio");
                          }
                        },
                        controller: controllerPrice,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          setState(() {
                            widget.priceInserted(controllerPrice.numberValue);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(height: 50.0),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(children: [
                        Text(Translations.of(context).text("state"),
                            style: TextStyle(fontSize: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                changeState(_value1);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(Translations.of(context).text("Nuevo"),
                                      style: TextStyle(fontSize: 10)),
                                  Container(
                                    child: Icon(Icons.fiber_new),
                                    margin: EdgeInsets.only(left: 5.0),
                                  ),
                                  Radio(
                                    value: _value1,
                                    onChanged: (_value1) =>
                                        changeState(_value1),
                                    activeColor: Colors.pink,
                                    groupValue: widget.prod.getState(),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                changeState(_value2);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      Translations.of(context)
                                          .text("Seminuevo"),
                                      style: TextStyle(fontSize: 10)),
                                  Container(
                                    child: Icon(MdiIcons.walletTravel),
                                    margin: EdgeInsets.only(left: 5.0),
                                  ),
                                  Radio(
                                    value: _value2,
                                    onChanged: (_value2) =>
                                        changeState(_value2),
                                    activeColor: Colors.pink,
                                    groupValue: widget.prod.getState(),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                changeState(_value3);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(Translations.of(context).text("Usado"),
                                      style: TextStyle(fontSize: 10)),
                                  Container(
                                    child: Icon(Icons.restore_page),
                                    margin: EdgeInsets.only(left: 5.0),
                                  ),
                                  Radio(
                                    value: _value3,
                                    onChanged: (_value3) =>
                                        changeState(_value3),
                                    activeColor: Colors.pink,
                                    groupValue: widget.prod.getState(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ]),
                      Container(
                        height: 130.0,
                        width: 1.0,
                        color: Colors.black12,
                        //margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      Column(children: [
                        Text(
                          Translations.of(context).text("state"),
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                changeSend(_conEnvio);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      Translations.of(context)
                                          .text("include_shipping"),
                                      style: TextStyle(fontSize: 10)),
                                  Container(
                                    child: Icon(Icons.local_shipping),
                                    margin: EdgeInsets.only(left: 5.0),
                                  ),
                                  Radio(
                                    value: _conEnvio,
                                    onChanged: (_conEnvio) =>
                                        changeSend(_conEnvio),
                                    activeColor: Colors.pink,
                                    groupValue:
                                        widget.prod.getStringShippinIncluded(),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                changeSend(_sinEnvio);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      Translations.of(context)
                                          .text("not_shipping"),
                                      style: TextStyle(fontSize: 10)),
                                  Container(
                                    child: Icon(MdiIcons.accountRemove),
                                    margin: EdgeInsets.only(left: 5.0),
                                  ),
                                  Radio(
                                      value: _sinEnvio,
                                      onChanged: (_sinEnvio) =>
                                          changeSend(_sinEnvio),
                                      activeColor: Colors.pink,
                                      groupValue: widget.prod
                                          .getStringShippinIncluded()),
                                ],
                              ),
                            ),
                          ],
                        )
                      ]),
                    ]),
              ]))
        ]);
  }

  Future<void> _rellenarInfo(String barcode) async {
    List<String> s = await getInfoISBN(barcode);
    setState(() {
      _isbn = barcode;
      widget.isbnInserted(barcode);
      controlerISBN.text = barcode;
      controlerTitle.text = s[0];
      widget.descriptionInserted(s[1]);
      formKey.currentState.validate();
      formKey.currentState.save();
    });
  }

  Future<void> gettingISBN(BuildContext context, String barcode) async {
    const tamanyoMaxpopUp = 144.4;
    _rellenarInfo(barcode).then((onValue) {
      Navigator.of(context).pop();
    });
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              //capturar boton atrás para mostrar mensaje
              onWillPop: () {/* No dejar cancelar */},
              child: AlertDialog(
                title: Text(
                  Translations.of(context).text("uploading_product"),
                  textAlign: TextAlign.center,
                ),
                content: Container(
                    height: tamanyoMaxpopUp,
                    child: Column(
                      children: <Widget>[
                        Center(child: BookaloProgressIndicator()),
                        Text(
                          Translations.of(context).text("wait_uploading"),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              ));
        });
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
