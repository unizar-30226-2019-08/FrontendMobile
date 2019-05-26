import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/detailed_product/isbn_viewer.dart';
import 'package:bookalo/widgets/detailed_product/tag_wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContentInfoConfirm extends StatefulWidget {
  final Product newProduct;

  const ContentInfoConfirm({Key key, this.newProduct}) : super(key: key);
  @override
  _ContentInfoConfirmState createState() => _ContentInfoConfirmState();
}

class _ContentInfoConfirmState extends State<ContentInfoConfirm> {
  @override
  Widget build(BuildContext contexst) {
    return Container(
      width: double.maxFinite,
      child: ListView(children: <Widget>[
        Text(
          widget.newProduct.getName(),
          maxLines: 4,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Text(
            widget.newProduct.priceToString(),
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
          ),
        ),
        Divider(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            widget.newProduct.getDescription(),
            overflow: TextOverflow.ellipsis,
            maxLines: 8,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Container(height: 10.0),
        Divider(),
        Center(
          child: Container(
            child: TagWraper(product: widget.newProduct),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
        (widget.newProduct.tags.length > 0 ? Divider() : Container()),
        ISBNViewer(
          product: widget.newProduct,
          sizeISBN: 24,
        ),
        Container(height: 10.0),
        productInfoConfirm(),
      ]),
    );
  }

  Widget productInfoConfirm() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width,
        height: height / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: width / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Translations.of(context).text("state"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.0, vertical: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          Translations.of(context)
                              .text(widget.newProduct.getState()),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      (widget.newProduct.getState().length < 7)
                          ? Container(width: 5)
                          : Container(),
                      getStateIconUpload(widget.newProduct)
                    ],
                  ) //Icono de estado
                ],
              ),
            ),
            VerticalDivider(color: Colors.black, indent: 3.0),
            //Columna de envío
            Container(
              width: width / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).text("ships"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.newProduct.isShippingIncluded() == true
                          ? Text(
                              Translations.of(context).text("include_shipping"),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w300))
                          : Text(Translations.of(context).text("not_shipping"),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w300)),
                      Container(width: 5),
                      Icon(widget.newProduct.isShippingIncluded()
                          ? Icons.local_shipping
                          : MdiIcons.accountRemove)
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget getStateIconUpload(Product product) {
    switch (product.getState()) {
      case "Nuevo":
        return Icon(Icons.fiber_new);
      case "Seminuevo":
        return Icon(MdiIcons.walletTravel);
      case "Usado":
        return Icon(Icons.restore_page);
      default:
        return Container();
    }
  }
}
