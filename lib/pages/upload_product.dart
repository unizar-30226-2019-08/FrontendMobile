/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'package:bookalo/translations.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/objects/product.dart';
//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:bookalo/widgets/upload_products/upload_images.dart';
import 'package:bookalo/widgets/upload_products/upload_title.dart';
import 'package:bookalo/widgets/upload_products/upload_tags.dart';
import 'package:bookalo/widgets/upload_products/upload_position.dart';

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
  List<bool> pagesValited = [true, false, false, false];
  var _pageOptions = [];
  @override
  void initState() {
    super.initState();
    newP = new Product(0, '', 0, false, [], '', false, '', 0, 0, 0, []);
    newP.setState('Nuevo');
    //	newP.getTags().forEach((tag) => kk.add(Tag(title: tag)));
    _pageOptions = [
      UploadImages(),
      UploadTitle(
        formKey: _formKeys[1],
        prod: newP,
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
        validate: (validado){setState(() {
          pagesValited[2] = validado;
        });},
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
        validate: (validado){setState(() {
          pagesValited[3] = validado;
        });},
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
    bool upload = false;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SimpleNavbar(preferredSize: Size.fromHeight(_height / 7.6)),
        body: _pageOptions[currentPage],
        //TODO: snackbar -> Mejorar mensaje
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (validarPaginas()) {
              //Subir
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
                  Translations.of(context).text("Por favor, complete los campos obligatorios",
                      /*params: [provider, (result.index * 100).toString()]*/),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
          inkColor: Colors.black, //optional, uses theme color if not specified
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.add_a_photo,
                  color: (pagesValited[2]) ? Colors.green : Colors.white,
                ),
                activeIcon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                title: Text(
                  "Fotos",
                  style: TextStyle(color: Colors.white),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.edit,
                  color: (validarNPaginas(1)) ? (pagesValited[1]) ? Colors.green : Colors.white : Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                title: Text(
                  "Producto",
                  style: TextStyle(color: Colors.white),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.dashboard,
                  color: (validarNPaginas(2)) ? (pagesValited[2]) ? Colors.green : Colors.white : Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: Text(
                  "Tags",
                  style: TextStyle(color: Colors.white),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.my_location,
                  color: (validarNPaginas(3)) ? (pagesValited[3]) ? Colors.green : Colors.white : Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
                title: Text(
                  "Posición",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),

        //CurvedNavigationBar(
        //	backgroundColor: Colors.white,
        //	color: Colors.pink,
        //	items: <Widget>[
        //		Icon(Icons.add, size: 30),
        //		Icon(Icons.list, size: 30),
        //		Icon(Icons.compare_arrows, size: 30),
        //		Icon(Icons.list, size: 30),
        //	],
        //	onTap: (index) {
        //			int i = 0;
        //	while(pagesValited[i] && i < index){
        //		i++;
        //	}
        //
        //		setState(() {
        //			currentPage = i;
        //		});
        //	},
        //),
        //	bottomNavigationBar: FancyBottomNavigation(
        //	tabs: [
        //			//TODO: Añadir a traslate. Modificar Iconos
        //			TabData(iconData: Icons.add_a_photo, title: 'Fotos'),
        //			TabData(iconData: Icons.search, title: 'Producto'),
        //			TabData(iconData: Icons.shopping_cart, title: 'Tags'),
        //			TabData(iconData: Icons.shopping_cart, title: 'Posición')
        //	],
        //	//Ejemplo para escuchar el cambio de estado
        //
        //	onTabChangedListener: (position) {
        ////			_formKeys[1].currentState.validate();
        //		int i = 0;
        //		while(pagesValited[i] && i < position){
        //			i++;
        //		}
        //
        //			setState(() {
        //				currentPage = i;
        //			});
        //		},
        //),
      ),
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
