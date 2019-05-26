/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'dart:io';
import 'package:bookalo/widgets/upload_products/content_info_confirm.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/confirmation_dialog.dart';
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
  List<bool> pagesValited = [false, false, false, true];
  List<File> imageFiles = [];
  var _pageOptions = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      //Si el producto existe
      _isNewProduct = false;
      newProduct = widget.product.clone();
      //Inicializar paginas validas con los campos del producto
      pagesValited[0] = newProduct.getImages().length > 1;
      pagesValited[1] =
          newProduct.getName().length > 1 && newProduct.price > 0.0;
      pagesValited[2] = newProduct.getDescription().length > 20;
    } else {
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
        prod: newProduct,
        priceInserted: (precio) {
          setState(() {
            newProduct.setPrice(precio);
          });
        },
        valitedPage: (valited) {
          setState(() {
            pagesValited[1] = valited;
          });
        },
        isbnInserted: (isbn) {
          setState(() {
            newProduct.setIsbn(isbn);
          });
        },
        tittleInserted: (tittle) {
          setState(() {
            newProduct.setName(tittle);
          });
        },
        descriptionInserted: (desc) {
          setState(() {
            newProduct.setDesciption(desc);
            pagesValited[2] = (desc.length > 20);
          });
        },
        stateProductInserted: (_state) {
          setState(() {
            newProduct.setState(_state);
          });
        },
      ),
      UploadTags(
        descriptionInserted: (desc) {
          setState(() {
            newProduct.setDesciption(desc);
          });
        },
        prod: newProduct,
        initialT: newProduct.getTags(),
        valitedPage: (valited) {
          setState(() {
            pagesValited[2] = valited;
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
        onPositionChange: (newPosition) {
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
            appBar: SimpleNavbar(
                title: Translations.of(context).text("upload_product"),
                iconData: Icons.add_shopping_cart,
                preferredSize: Size.fromHeight(_height / 10)),
            body: _pageOptions[_currentPage],
            floatingActionButton: Builder(
              builder: (contextButton) {
                return FloatingActionButton(
                  child: Icon(Icons.file_upload),
                  backgroundColor:
                      (validatePages() ? Colors.green : Colors.grey),
                  onPressed: () async {
                    if (validatePages()) {
                      ConfirmAction action = await askConfirmation(
                          context,
                          "check_product",
                          "ok_upload",
                          "cancel",
                          ContentInfoConfirm(newProduct: newProduct));
                      if (action == ConfirmAction.ACCEPT) {
                        bool result = await _uploading(contextButton);
                        if (result) {
                          await askConfirmation(
                              context,
                              "subida_completed",
                              "understand",
                              "",
                              Text(Translations.of(context)
                                  .text("upload_product_ok")));
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
                          Translations.of(context).text("empty_fields"),
                          style: TextStyle(fontSize: 17.0),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: Translations.of(context).text(
                              "understand"),
                          onPressed: () {
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                          },
                        ),
                      ));
                    }
                  },
                );
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

  Future<bool> _uploading(BuildContext contextPadre) async {
    double _height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  Translations.of(context).text("uploading_product"),
                  textAlign: TextAlign.center,
                ),
                content: Container(
                    height: 1.5 * (_height / 5),
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
      result = await uploadNewProduct(newProduct, imageFiles,
          seeErrorWith: contextPadre);
    } else {
      result =
          await editProduct(newProduct, imageFiles, seeErrorWith: contextPadre);
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
