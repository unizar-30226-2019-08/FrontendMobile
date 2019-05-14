/*
 * FICHERO:     detailed_product.dart
 * DESCRIPCIÓN: clases relativas al widget DetailedProduct
 * CREACIÓN:    19/04/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/utils/silver_header.dart';
import 'package:bookalo/widgets/detailed_product/radial_button.dart';
import 'package:bookalo/widgets/detailed_product/user_product.dart';
import 'package:bookalo/widgets/detailed_product/product_map.dart';
import 'package:bookalo/widgets/detailed_product/product_info.dart';
import 'package:bookalo/widgets/detailed_product/distance_chip.dart';
import 'package:bookalo/widgets/detailed_product/tag_wraper.dart';
import 'package:bookalo/widgets/detailed_product/image_swipper.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailedProduct extends StatefulWidget {
  final bool isLiked;
  final Product product;
  final User user;
  DetailedProduct({Key key, this.product, this.user, this.isLiked})
      : super(key: key);

  @override
  _DetailedProductState createState() => _DetailedProductState();
}

class _DetailedProductState extends State<DetailedProduct> {
  bool isMarkedAsFavorite;

  @override
  void initState() {
    super.initState();
    isMarkedAsFavorite = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool longTitle = widget.product.getName().length > 17;
    return Scaffold(
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0, right: 20.0),
                        child: DistanceChip(
                            userPosition:
                                ScopedModel.of<FilterQuery>(context).position,
                            targetPosition: widget.product.getPosition()),
                      ),
                    ),
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
                          Container(
                            width: width / 1.6,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              widget.product.getName(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.w300),
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
                    Container(
                        margin: EdgeInsets.only(
                            bottom: (longTitle ? height / 25 : 0)),
                        child: RadialButton(
                            product: widget.product,
                            sellerId: widget.user.uid,
                            wasMarkedAsFavorite: widget.isLiked,
                            onFavorite: () {
                              setState(() {
                                isMarkedAsFavorite = !isMarkedAsFavorite;
                              });
                            })),
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
                Center(
                  child: Container(
                    child: TagWraper(product: widget.product),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ),
                Container(height: 10.0),
                ProductInfo(
                    widget.product,
                    (!widget.isLiked && isMarkedAsFavorite),
                    (widget.isLiked && !isMarkedAsFavorite)),
                Container(height: 10.0),
                Center(child: UserProduct(widget.user, widget.product)),
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
