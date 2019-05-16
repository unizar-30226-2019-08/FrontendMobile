/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'dart:io';

import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:bookalo/widgets/upload_products/upload_images.dart';
import 'package:bookalo/widgets/upload_products/upload_title.dart';
import 'package:bookalo/widgets/upload_products/upload_tags.dart';
import 'package:bookalo/widgets/upload_products/upload_position.dart';

enum ConfirmAction { CANCEL, ACCEPT }
const tamanyoMaxpopUp = 144.4;

/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.
 * //TODO: add descripcion
 */
class UploadProduct extends StatefulWidget {
  UploadProduct({Key key}) : super(key: key);
  _UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Product newP;
  bool finalizado = false;
  List<bool> pagesValited = [false, false, true, true];
  List<File> imageneFile = [];

  var _pageOptions = [];

  @override
  void initState() {
    super.initState();
    newP = new Product(0, '', 0, false, [], '', false, '', 0, 0, 0, []);
    newP.setState('Nuevo');
    _pageOptions = [
      UploadImages(
        imagesList: imageneFile,
        validate: ((val) { 
          setState(() {pagesValited[0] = val; }); 
          }),
      ),
      UploadTitle(
        formKey: _formKeys[1],
        prod: newP,
        priceInserted: (precio) {
          setState(() {
            newP.setPrice(precio);
          });
        },
        valitedPage: (valited) {
          setState(() {
            pagesValited[1] = valited;
          });
        },
        isbnInserted: (isbn) {
          setState(() {
            newP.setIsbn(isbn);
          });
        },
        tittleInserted: (tittle) {
          setState(() {
            newP.setName(tittle);
          });
        },
        descriptionInserted: (desc) {
          setState(() {
            newP.setDesciption(desc);
          });
        },
        stateProductInserted: (_state) {
          setState(() {
            newP.setState(_state);
          });
        },
      ),
      UploadTags(
        initialT: newP.getTags(),
        validate: (validado) {
          setState(() {
            pagesValited[2] = validado;
          });
        },
        onDeleteTag: (tag) {
          setState(() {
            newP.deleteTag(tag);
          });
        },
        onInsertTag: (tag) {
          setState(() {
            newP.insertTag(tag);
          });
        },
      ),
      UploadPosition(
        validate: (validado) {
          setState(() {
            pagesValited[3] = validado;
          });
        },
      ),
    ];
  }

  int currentPage = 0;
  //Contenido de cada página

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async {
          ConfirmAction accion = await _cancelarUpload(context);
          if (accion == ConfirmAction.ACCEPT) {
            Navigator.pop(context);
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: SimpleNavbar(preferredSize: Size.fromHeight(_height / 7.6)),
            body: _pageOptions[currentPage],
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (validarPaginas()) {
                  //Subir
                  // if(imageneFile.length > 0){
                  //imageneFile.add(File('/Almacenamiento interno compartido/WhatsApp/Media/WhatsApp Images/IMG-20141026-WA0003.jpg'));

                  ConfirmAction action = await _confirmarUpload(context);

                  if (action == ConfirmAction.ACCEPT) {
                    if (await uploadNewProduct(newP, imageneFile)) {
                      await _ackAlert(context);
                      Navigator.pop(context);
                    }
                  }
                } else {
                  int i = 0;
                  while (pagesValited[i] && i < pagesValited.length) {
                    i++;
                  }
                  setState(() {
                    currentPage = i;
                  });
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      Translations.of(context).text("completar_campos"),
                      style: TextStyle(fontSize: 17.0),
                    ),
                    action: SnackBarAction(
                      label: Translations.of(context).text("accept"),
                      onPressed: () {
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                      },
                    ),
                  ));
                }
              },
              child: Icon(Icons.file_upload),
              backgroundColor: (validarPaginas() ? Colors.green : Colors.grey),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
              backgroundColor: Colors.pink,
              opacity: .2,
              currentIndex: currentPage,
              onTap: (index) {
                int i = 0;
                while (pagesValited[i] && i < index) {
                  i++;
                }
                setState(() {
                  currentPage = i;
                });
              },
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              elevation: 8,
              fabLocation: BubbleBottomBarFabLocation.end, //new
              hasNotch: true, //new
              hasInk: true, //new, gives a cute ink effect
              inkColor:
                  Colors.black, //optional, uses theme color if not specified
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    activeIcon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    title: Text(
                      Translations.of(context).text("Fotos"),
                      style: TextStyle(color: Colors.white),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.edit,
                      color: (validarNPaginas(1)) ? Colors.white : Colors.grey[800],
                    ),
                    activeIcon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    title: Text(
                      Translations.of(context).text("Producto"),
                      style: TextStyle(color: Colors.white),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.dashboard,
                      color: (validarNPaginas(2)) ? Colors.white : Colors.grey[800],
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    title: Text(
                      Translations.of(context).text("tags"),
                      style: TextStyle(color: Colors.white),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.my_location,
                      color: (validarNPaginas(3)) ? Colors.white : Colors.grey[800],
                    ),
                    activeIcon: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    title: Text(
                      Translations.of(context).text("position"),
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ));
  }

  Future<ConfirmAction> _cancelarUpload(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translations.of(context).text('cancel_upload'),
            style: TextStyle(color: Colors.pink, fontSize: 24),
          ),
          content: Container(
            height: tamanyoMaxpopUp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  size: 35,
                ),
                Divider(),
                //Icon(Icons.new_releases),
                //Icon(Icons.warning),
                Text(
                  Translations.of(context).text("cancel_upload_text"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Cancel')),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: Text(
                Translations.of(context).text('Continue'),
                style: TextStyle(color: Colors.pink[800]),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  Future<ConfirmAction> _confirmarUpload(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translations.of(context).text('subir_nuevo_producto'),
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          //   content: Container(
          content: Column(
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 35,
                color: Colors.purple,
              ),
              Text(
                Translations.of(context).text("text_verify"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              //Divider(),
              Divider(
                color: Colors.black,
                height: 3,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(Translations.of(context).text("Producto") +
                    ": " +
                    newP.getName()),
                Divider(),
                Text("ISBN: " + newP.getISBN()),
                Divider(),
                Text(Translations.of(context).text("price") +
                    ": " +
                    newP.getPrice().toString() +
                    "€"),
                Divider(),
                Text(Translations.of(context).text("state") +
                    ": " +
                    newP.getState()),
                Divider(),
                Text(Translations.of(context).text("tipo_envio") +
                    ": " +
                    Translations.of(context).text((newP.isShippingIncluded()
                        ? "con_envio"
                        : "sin_envio"))),
                Divider(),
                Text(Translations.of(context).text("description") +
                    ":\n" +
                    ((newP.getDescription().length <= 30)
                        ? newP.getDescription()
                        : newP.getDescription().substring(0, 30) + "...")),
                Divider(),
                Text(Translations.of(context).text("tags") +
                    ":\n AQUI VAN LOS TAGS"),
              ])
            ],
          ),
          //),

          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Cancel'), style: TextStyle(color: Colors.pink[800]),),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: Text(Translations.of(context).text('Continue')),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translations.of(context).text("subida_completed"),
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: tamanyoMaxpopUp,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.done_all,
                  size: 35,
                  color: Colors.green,
                ),
                Divider(),
                Text(Translations.of(context).text("upload_product_ok")),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Gracias')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool validarPaginas() {
    bool v = true;
    pagesValited.forEach((x) {
      v = v && x;
    });
    return v;
  }

  bool validarNPaginas(int n) {
    bool v = true;
    for (int i = 0; i < n; i++) {
      v = v && pagesValited[i];
    }
    return v;
  }
}
