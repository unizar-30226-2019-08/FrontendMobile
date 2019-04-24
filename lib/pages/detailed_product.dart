/*
 * FICHERO:     detailed_product.dart
 * DESCRIPCIÓN: clases relativas al widget DetailedProduct
 * CREACIÓN:    19/04/2019
 */

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/radial_button.dart';
import 'package:bookalo/widgets/user_product.dart';
import 'package:bookalo/widgets/filter/distance_map.dart';

class DetailedProduct extends StatefulWidget {
  final Product product;
  DetailedProduct({Key key, this.product}) : super(key: key);

  @override
  _DetailedProductState createState() => _DetailedProductState();
}

class _DetailedProductState extends State<DetailedProduct> {
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
            delegate: _SliverAppBarDelegate(
                minHeight: (longTitle ? height/3 : height/4),
                maxHeight: (longTitle ? height/2 : height/2.4),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                          widget.product.getImage(),
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: 3,
                      pagination: new SwiperPagination(
                        alignment: Alignment(0, -0.9),
                      ),
                      control: new SwiperControl(),
                    ),
                    Container(
                      height: (longTitle ? height/6 : height/8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                      ),
                      padding: EdgeInsets.only(top: height/40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: width/1.6,
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
                      margin: EdgeInsets.only(bottom: (longTitle ? height/25 : 0)),
                      child: RadialButton()
                    ),
                  ],
                )),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Divider(),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    widget.product.getDescription(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                UserProduct(),
                DistanceMap(distanceRadius: 7000, height: 150.0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
