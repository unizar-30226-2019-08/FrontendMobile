/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'dart:io';

import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/upload_products/widgets_tags_uploader/show_tags_confirm.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:bookalo/widgets/upload_products/upload_images.dart';
import 'package:bookalo/widgets/upload_products/upload_title.dart';
import 'package:bookalo/widgets/upload_products/upload_tags.dart';
import 'package:bookalo/widgets/upload_products/upload_position.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

enum ConfirmAction { CANCEL, ACCEPT } //Acciones de usuario en PopUps
const tamanyoMaxpopUp = 144.4; //Maximo tamaño para PopUps ACK y Cancelar

/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.
 *                Este widget Construye con una menu inferior todas las vistas necesarias
 *                Para la subida de un producto nuevo o su modificación.
 *                Termina cuando el usuario consigue subir un producto nuevo o modificado
 *                O cuando explicitamente el usuario ha cancelado dicha subida
 */
class UploadProduct extends StatefulWidget {
  final Product prod;
  UploadProduct({Key key, this.prod}) : super(key: key);
  _UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
  bool success = false;
  //true si y solo si el producto es nuevo. False si se esta modificando
  bool newProduct = true;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  //Producto a subir
  Product newP = Product.empty();
  AutoV autoV = AutoV(false);
  //validación de pasos. Sólo se permite hacer submit
  //    si  para todo 'i' € {0, pagesValited.length}, pagesValited[i] == true
  List<bool> pagesValited = [false, false, false, true];
  //imagenes del producto
  List<File> imageneFile = [];
  //Contendra los widgetsa visualizar (ver initState)
  var _pageOptions = [];

  //Actual widget a mostrar
  int currentPage = 0;

  //List<String> debug_get_images = [
  //  "https://bookalo.es/media/Captura_de_pantalla_de_2019-05-13_10-43-18.png",
  //  "https://bookalo.es/media/bolas-plastico.jpg",
  //  "https://bookalo.es/media/yosemite-national-park-3840x2160-winter-mountains-4k-6334_j22ffNV.jpg",
  //  "https://bookalo.es/media/manley_6_unidades_LKZzKYO.jpg"
  //];

  //Keys que verifican la validación
  // Actualmente sólo se esta usando _formkeay[1]
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  /**
	 * Habrá inicialidado los Widgets de cada página
	 * y newP
	 */
  @override
  void initState() {
    super.initState();

    if (widget.prod != null) {
      newProduct = false;
      newP = widget.prod;
      //Por cada imagen -> descargar y almacenar
      widget.prod.getImages().forEach((image) async {
        var cacheManager = await CacheManager.getInstance();
        File file = await cacheManager.getFile(image);
        imageneFile.add(file);
      });
    }
    pagesValited[0] = imageneFile.length > 0 ||
        (newP != null &&
            /* debug_get_images.length > 0); */ newP.getImages().length > 0);

    _pageOptions = [
      UploadImages(
        imagesList: imageneFile,
        imagesNW: newP.getImages(),
        //imagesNW: debug_get_images,
        validate: ((val) {
          setState(() {
            pagesValited[0] = val;
          });
        }),
      ),
      UploadTitle(
        formKey: _formKeys[1],
        autoV: autoV,
        prod: newP,
        priceInserted: (precio) {
          setState(() {
            newP.setPrice(precio);
            autoV.autovalidate = true;
          });
        },
        valitedPage: (valited) {
          setState(() {
            pagesValited[1] = valited;
            autoV.autovalidate = true;
          });
        },
        isbnInserted: (isbn) {
          setState(() {
            newP.setIsbn(isbn);
            autoV.autovalidate = true;
          });
        },
        tittleInserted: (tittle) {
          setState(() {
            newP.setName(tittle);
            autoV.autovalidate = true;
          });
        },
        /* descriptionInserted: (desc) {
          setState(() {
            newP.setDesciption(desc);
            autoV.autovalidate = true;
          });
        }, */
        stateProductInserted: (_state) {
          setState(() {
            newP.setState(_state);
            autoV.autovalidate = true;
          });
        },
      ),
      UploadTags(
        descriptionInserted: (desc) {
          setState(() {
            newP.setDesciption(desc);
            autoV.autovalidate = true;
          });
        },
        prod: newP,

        initialT: newP.getTags(),
        valitedPage: (valited) {
          setState(() {
            pagesValited[2] = valited;
            //autoV.autovalidate = true;
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

  /**
	 * Habrá contruido la vista general para poder subir un producto nuevo o modificarlo
	 */
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
        //capturar boton atrás para mostrar mensaje
        onWillPop: () async {
          ConfirmAction accion = await _cancelarUpload(context);
          if (accion == ConfirmAction.ACCEPT) {
            //Salir si el cliente lo pide
            Navigator.pop(context);
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            //
            key: _scaffoldKey, //key para mostrar snackbars
            appBar: SimpleNavbar(preferredSize: Size.fromHeight(_height / 7.6)),
            body: _pageOptions[
                currentPage], //cuerpo = paginas iniciadas en initState
            floatingActionButton: FloatingActionButton(
              //Boton Submit
              child: Icon(Icons.file_upload),
              backgroundColor: (validarPaginas() ? Colors.green : Colors.grey),
              onPressed: () async {
                if (validarPaginas()) {
                  //popup de confirmacion <-> (validarPaginas == true)
                  ConfirmAction action = await _confirmarUpload(context);

                  if (action == ConfirmAction.ACCEPT) {
                    setState(() {
                      success = false;
                    });
                    await _uploading(context);
                    print("exito en la accion " + success.toString());
                    if (success) {
                      await _ackAlert(context);
                      Navigator.pop(context);
                    }
                  }
                } else {
                  //Si no se ha validado todo -> mostrar primera pagina no valida
                  int i = 0;
                  while (pagesValited[i] && i < pagesValited.length) {
                    i++;
                  }
                  setState(() {
                    currentPage = i;
                  });
                  //Mostrar mensaje de error "Rellenar campos"
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
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
              //Bara de navegacion inferior
              backgroundColor: Colors.pink,
              opacity: .2,
              currentIndex: currentPage,
              onTap: (index) {
                //Al intentar cambiar de pagina, verificar que todo lo anterior es correcto
                int i = 0;
                while (pagesValited[i] && i < index) {
                  i++;
                }
                setState(() {
                  //Mostrar primera pagina con campos incompletos O pagina solicitada
                  currentPage = i;
                });
              },
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              elevation: 8,
              fabLocation: BubbleBottomBarFabLocation.end, //new
              hasNotch: true, //new
              hasInk: true, //new, gives a cute ink effect
              inkColor: Colors.black, //Color fondo de pagina seleccionada
              items: <BubbleBottomBarItem>[
                //Botones del menu
                BubbleBottomBarItem(
                    //Anyadir fotos
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
                    //Anyadir descripcion
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.edit,
                      color: (validarNPaginas(1))
                          ? Colors.white
                          : Colors.grey[800],
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
                    //Anyadir tags
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.dashboard,
                      color: (validarNPaginas(2))
                          ? Colors.white
                          : Colors.grey[800],
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
                    //posicion
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.my_location,
                      color: (validarNPaginas(3))
                          ? Colors.white
                          : Colors.grey[800],
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

/** 
 * Habrá mostrado un PopUp de advertencia de que si el usuario continua, perderá los datos introducidos
 * y devuelve la acción € ConfirmAction = {ACEPTAR, CANCELAR} siendo esta la intención del usuario
 */

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

/** 
 *  Habrá mostrado un PopUp de confimación de subida de producto con todos los datos del producto
 *  Y devolverá una acción perteneciente ConfirmAction ={ACEPTAR, CANCELAR} con la acción elegida
 * del usuario
 */
  Future<ConfirmAction> _confirmarUpload(BuildContext context) async =>
      showDialog<ConfirmAction>(
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
                  Text(Translations.of(context).text("tags")),
                  ShowTagsConfirm(tags: newP.getTags())
                ])
              ],
            ),
            //),

            actions: <Widget>[
              FlatButton(
                child: Text(
                  Translations.of(context).text('Cancel'),
                  style: TextStyle(color: Colors.pink[800]),
                ),
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
/**
 * Mostrará un mensaje de confimación de que el producto ha subido Correctamente
 */
  Future<void> _ackAlert(
    BuildContext context,
  ) {
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
        });
  }

/**
 * 	Pre: Success y newProduct son variables globales de la clase _UploadProductState
 * 			y newProdcuto == true si y solo si el producto a subir es nuevo
 *  Habrá mostrado un Alert miestras espera la respuesta del servidor.
 *  y Success = (uploadNewProduct si (newProduct == true) || editProduct si (newProduct == false))
 */
  Future<bool> _uploading(BuildContext context) {
    if (newProduct) {
      uploadNewProduct(newP, imageneFile).then((suc) {
        print("Done");
        setState(() {
          this.success = suc;
        });
        Navigator.of(context).pop(this.success);
      });
    } else {
      editProduct(newP, imageneFile).then((suc) {
        print("Done");
        setState(() {
          this.success = suc;
        });
        Navigator.of(context).pop(this.success);
      });
    }

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

/**
 * True <-> para todo i € {0, pagesValited.length}, pagesValited[i] == true
 */
  bool validarPaginas() {
    bool v = true;
    pagesValited.forEach((x) {
      v = v && x;
    });
    return v;
  }

/** 
 * PRE: n <= pagesValited.length
 * True <-> para todo i € {0, n}, pagesValited[i] == true
 */
  bool validarNPaginas(int n) {
    bool v = true;
    for (int i = 0; i < n; i++) {
      v = v && pagesValited[i];
    }
    return v;
  }
}
