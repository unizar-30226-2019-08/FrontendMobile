/*
 * FICHERO:     product_view.dart
 * DESCRIPCIÓN: visor del producto de la apntalla principal
 * CREACIÓN:    15/03/2019
 *
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/widgets/detailed_product/distance_chip.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/detailed_product.dart';
import 'package:bookalo/pages/own_product.dart';
import 'package:bookalo/objects/user.dart';

/*
 * CLASE: ProductView
 * DESCRIPCIÓN: widget de vista de producto de la pantalla principal
 */
class ProductView extends StatelessWidget {
  final Product _product;
  final User _user;
  final bool itsMine;
  final bool isLiked;
  ProductView(this._product, this._user, this.itsMine, this.isLiked);

  /*
   * Pre:   ---
   * Post:  devuelve un Widget (Card) con el precio, descripcion y tags del producto
   *        vendido y  valoraciones del vendedor
   */
  Widget priceCard(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(_product.priceToString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    )),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, bottom: 8, right: 10.0),
            child: Text(
              this._product.getDescription(),
              textAlign: TextAlign.justify,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: StaticStars(
                _user.getRating(), Colors.black, _user.getRatingsAmount()),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 16, bottom: 8),
          //   child: Text(
          //     _product.getName(),
          //     style: TextStyle(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 30.0
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  /*
   * Pre: ---
   * Post: devuelve un Widget (Card) con la imagen y nombre del producto vendido
   */
  Widget imageCard(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(alignment: Alignment.topRight, children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_product.getImages()[0]),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50.0,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(_product.getTags().length, (i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Chip(
                            label: Text(
                              _product.getTags()[i],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            backgroundColor: Colors.pink,
                          ),
                        );
                      })),

                  // child: ListTile(
                  //   title: Text(
                  //     this._product.getName(),
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       // fontSize: 40,
                  //     ),
                  //   ),
                  //   trailing: IconButton(
                  //     icon: Icon(
                  //         (itsMine ? Icons.edit : Icons.chat_bubble_outline),
                  //         color: Colors.pink,
                  //         size: 40),
                  //     onPressed: () {
                  //       if (itsMine) {
                  //         //TODO: pantalla de edit
                  //       } else {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => Chat(
                  //                   user: _user,
                  //                   product: _product,
                  //                   interest: Interest.offers)),
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: (!_product.checkfForSale()
                ? Chip(
                    label: Text(
                      Translations.of(context).text('sold_tab'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    backgroundColor: Colors.pink,
                  )
                : DistanceChip(
                    userPosition: ScopedModel.of<FilterQuery>(context).position,
                    targetPosition: _product.getPosition(),
                  )),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: height / 50),
          child: SizedBox(
            child: Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  child: Container(
                    color: Colors.transparent,
                    width: width / 1.3,
                    height: height / 2.1,
                  ),
                ),
                Positioned(
                  left: 100.0,
                  child: Container(
                    height: height / 2.1,
                    width: width / 1.7,
                    child: imageCard(context),
                  ),
                ),
                Positioned(
                    top: height / 20,
                    right: width / 3,
                    child: Container(
                      height: height / 2.9,
                      width: width / 2,
                      child: priceCard(context),
                    ))
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (!itsMine) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedProduct(
                      product: this._product,
                      user: this._user,
                      isLiked: this.isLiked,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OwnProduct(
                      product: this._product,
                    )),
          );
        }
      },
    );
  }
}
