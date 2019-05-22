/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/confirmation_dialog.dart';
import 'package:bookalo/widgets/upload_products/widgets_tags_uploader/show_tags_confirm.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/upload_products/upload_images.dart';
import 'package:bookalo/widgets/upload_products/upload_title.dart';
import 'package:bookalo/widgets/upload_products/upload_tags.dart';
import 'package:bookalo/widgets/upload_products/upload_position.dart';


/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.
 *                Este widget Construye con una menu inferior todas las vistas necesarias
 *                Para la subida de un producto nuevo o su modificación.
 *                Termina cuando el usuario consigue subir un producto nuevo o modificado
 *                O cuando explicitamente el usuario ha cancelado dicha subida
 */
class UploadProduct extends StatefulWidget {
  final Product product;

  UploadProduct({Key key, this.product}) : super(key: key);
  _UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
  bool _isNewProduct = true;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Product newProduct = Product.empty();
  AutoV autoV = AutoV(false);
  List<bool> pagesValited = [false, false, false, true];
  List<File> imageFiles = [];
  var _pageOptions = [];
  int _currentPage = 0;



  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      
      _isNewProduct = false;
      newProduct = widget.product.clone();
      print("Editando pronducto: " + newProduct.getName());
      pagesValited[0] = newProduct.getImages().length > 1;
      pagesValited[1] = newProduct.getName().length > 1 && newProduct.price > 0.0;
      pagesValited[2] = newProduct.getDescription().length > 20;
    }else{
      newProduct.setPosition(ScopedModel.of<FilterQuery>(context).position);
    }
    pagesValited[0] = imageFiles.length > 0 ||
        (newProduct != null && newProduct.getImages().length > 0);

    _pageOptions = [
      UploadImages(
        imagesList: imageFiles,
        imagesNW: newProduct.getImages(),
        validate: ((val) {
          setState(() {
            pagesValited[0] = val;
          });
        }),
      ),
      UploadTitle(
        autoV: autoV,
        prod: newProduct,
        priceInserted: (precio) {
          setState(() {
            newProduct.setPrice(precio);
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
            newProduct.setIsbn(isbn);
            autoV.autovalidate = true;
          });
        },
        tittleInserted: (tittle) {
          setState(() {
            newProduct.setName(tittle);
            autoV.autovalidate = true;
          });
        },
        descriptionInserted: (desc) {
          setState(() {
            newProduct.setDesciption(desc);
            pagesValited[1] = (desc.length > 2);
            autoV.autovalidate = true;
          });
        },
        stateProductInserted: (_state) {
          setState(() {
            newProduct.setState(_state);
            autoV.autovalidate = true;
          });
        },
      ),
      UploadTags(
        descriptionInserted: (desc) {
          setState(() {
            newProduct.setDesciption(desc);
            autoV.autovalidate = true;
          });
        },
        prod: newProduct,
        initialT: newProduct.getTags(),
        valitedPage: (valited) {
          setState(() {
            pagesValited[2] = valited;
            //autoV.autovalidate = true;
          });
        },
        onDeleteTag: (tag) {
          setState(() {
            newProduct.deleteTag(tag);
          });
        },
        onInsertTag: (tag) {
          setState(() {
            newProduct.insertTag(tag);
          });
        },
      ),
      UploadPosition(
        initialPosition: newProduct.getPosition(),
        validate: (validado) {
          setState(() {
            pagesValited[3] = validado;
          });
        },
        onPositionChange: (newPosition){
          newProduct.setPosition(newPosition);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          ConfirmAction actionSelected = await askConfirmation(
              context,
              "warning",
              "ok_abort",
              "cancel",
              Text(Translations.of(context).text("cancel_upload_text")));
          if (actionSelected == ConfirmAction.ACCEPT) {
            Navigator.pop(context);
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _scaffoldKey, //key para mostrar snackbars
            appBar: SimpleNavbar(preferredSize: Size.fromHeight(_height / 7.6)),
            body: _pageOptions[_currentPage],
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.file_upload),
              backgroundColor: (validatePages() ? Colors.green : Colors.grey),
              onPressed: () async {
                if (validatePages()) {
                  ConfirmAction action = await askConfirmation(
                      context,
                      "check_product",
                      "ok_upload",
                      "cancel",
                      Text("")); //TODO: revisión del producto
                  if (action == ConfirmAction.ACCEPT) {
                    bool result = await _uploading(context);
                    if (result) {
                      await _ackAlert(context);
                      Navigator.pop(context);
                    }
                  }
                } else {
                  setState(() {
                    _currentPage = pagesValited.indexOf(
                        pagesValited.firstWhere((validate) => !validate));
                  });
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      Translations.of(context).text("completar_campos"),
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ));
                }
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
              backgroundColor: Colors.pink,
              opacity: .2,
              currentIndex: _currentPage,
              onTap: (index) {
                int firstNotValid = pagesValited.indexOf(pagesValited
                    .firstWhere((validate) => !validate, orElse: () => false));
                setState(() {
                  if (firstNotValid == -1) {
                    _currentPage = index;
                  } else {
                    _currentPage =
                        index <= firstNotValid ? index : firstNotValid;
                  }
                });
              },
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              elevation: 8,
              fabLocation: BubbleBottomBarFabLocation.end,
              hasNotch: true,
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
                      Translations.of(context).text("pictures"),
                      style: TextStyle(color: Colors.white),
                    )),
                BubbleBottomBarItem(
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
                      Translations.of(context).text("product"),
                      style: TextStyle(color: Colors.white),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(
                      MdiIcons.tagPlus,
                      color: (validarNPaginas(2))
                          ? Colors.white
                          : Colors.grey[800],
                    ),
                    activeIcon: Icon(
                      MdiIcons.tagPlus,
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

/*
 * Mostrará un mensaje de confimación de que el producto ha subido Correctamente
 */
  Future<void> _ackAlert(BuildContext context) async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              Translations.of(context).text("subida_completed"),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 400,
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

  Future<bool> _uploading(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {/* No dejar salir */},
          child: AlertDialog(
            title: Text(
              Translations.of(context).text("uploading_product"),
              textAlign: TextAlign.center,
            ),
            content: Container(
                height: 500,
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
    bool result = false;
    if (_isNewProduct) {
      result = await uploadNewProduct(newProduct, imageFiles);
    } else {
      result = await editProduct(newProduct, imageFiles);
    }
    Navigator.pop(context);
    return result;
  }

/*
 * True <-> para todo i € {0, pagesValited.length}, pagesValited[i] == true
 */
  bool validatePages() {
    bool v = true;
    pagesValited.forEach((x) {
      v = v && x;
    });
    return v;
  }

/*
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
