/*
 * FICHERO:     detailed_product.dart
 * DESCRIPCIÓN: clases relativas al widget OwnProduct
 * CREACIÓN:    19/04/2019
 */

import 'package:bookalo/widgets/detailed_product/isbn_viewer.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/utils/silver_header.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/pages/upload_product.dart';
import 'package:bookalo/widgets/confirmation_dialog.dart';
import 'package:bookalo/widgets/detailed_product/product_map.dart';
import 'package:bookalo/widgets/detailed_product/product_info.dart';
import 'package:bookalo/widgets/detailed_product/tag_wraper.dart';
import 'package:bookalo/widgets/detailed_product/image_swipper.dart';
import 'package:bookalo/translations.dart';

class OwnProduct extends StatefulWidget {
  final Product product;
  OwnProduct({Key key, this.product}) : super(key: key);

  @override
  _DetailedProductState createState() => _DetailedProductState();
}

class _DetailedProductState extends State<OwnProduct> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    bool longTitle = widget.product.getName().length > 17;
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
                minHeight: (longTitle ? height / 3 : height / 4),
                maxHeight: (longTitle ? height / 2 : height / 2.4),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    ImageSwiper(product: widget.product, expandible: true),
                    Container(
                      height: (longTitle ? height / 6 : height / 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                      ),
                      padding: EdgeInsets.only(top: height / 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                widget.product.getName(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text(
                              widget.product.priceToString(),
                              style: TextStyle(
                                  fontSize: 45.0, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.product.getDescription(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(height: 10.0),
                Divider(),
                Center(
                  child: Container(
                    child: TagWraper(product: widget.product),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ),
                (widget.product.tags.length > 0 ? Divider() : Container()),
                ISBNViewer(product: widget.product),
                ProductInfo(widget.product, false, false),
                Container(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.pink, width: 3.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.edit, color: Colors.pink, size: 30.0),
                          Text(
                            Translations.of(context).text("edit_product"),
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.pink[600],
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadProduct(
                                      product: widget.product,
                                    )));
                      },
                    ),
                    OutlineButton(
                      borderSide:
                          BorderSide(color: Colors.grey[800], width: 3.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete_forever,
                              color: Colors.grey[800], size: 30.0),
                          Text(
                            Translations.of(context).text("remove_product"),
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        ConfirmAction action = await askConfirmation(
                            context,
                            "delete_sure",
                            "ok_delete",
                            "cancel",
                            Text(Translations.of(context).text(
                                "delete_explanation",
                                params: [widget.product.getName()])));
                        if (action == ConfirmAction.ACCEPT) {
                          if (await deleteProduct(widget.product.getId(),
                              seeErrorWith: _scaffoldKey)) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ],
                ),
                Container(height: 20.0),
                ProductMap(
                    position: widget.product.getPosition(),
                    height: height / 5,
                    expandible: true)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
