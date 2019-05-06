/*
 * FICHERO:     product_view.dart
 * DESCRIPCIÓN: visor del producto de la apntalla principal
 * CREACIÓN:    15/03/2019
 *
 */
import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:geo/geo.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/pages/chat.dart';
import 'package:bookalo/widgets/distance_chip.dart';
import 'package:bookalo/translations.dart';

/*
 * CLASE: ProductView
 * DESCRIPCIÓN: widget de vista de producto de la pantalla principal
 */
class ProductView extends StatelessWidget {
  final Product _product;
  final double _stars;
  final int _reviews;
  final List<Tag> _tags = [
    Tag(
      id: 1,
      title: 'mates',
    ),
    Tag(
      id: 1,
      title: 'universidad',
    ),
    Tag(
      id: 1,
      title: 'primero',
    ),
    Tag(
      id: 1,
      title: 'ciencias',
    ),
  ];
  ProductView(this._product, this._stars, this._reviews);

  /*
   * Pre:   ---
   * Post:  devuelve un Widget (Card) con el precio, descripcion y tags del producto
   *        vendido y  valoraciones del vendedor
   */
  Widget priceCard(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
            child: StaticStars(this._stars, Colors.black, this._reviews),
          ),
          SizedBox(
            height: height / 9,
            child: SelectableTags(
              textOverflow: TextOverflow.ellipsis,
              height: height / 30,
              tags: _tags,
              fontSize: 11.0,
              onPressed: (tag) {},
              margin: EdgeInsets.all(5.0),
              activeColor: Colors.pink,
            ),
          )
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
                image: NetworkImage(_product.getImage()),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: ListTile(
                    title: Text(
                      this._product.getName(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontSize: 40,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.chat_bubble_outline,
                          color: Colors.pink, size: 40),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Chat()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: (_product.getSold()
                ? Chip(
                    label: Text(
                      Translations.of(context).text('sold_tab'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    backgroundColor: Colors.pink,
                  )
                : DistanceChip(
                    userPosition: LatLng(0.0, 0.0),
                    targetPosition: LatLng(0.003, 0.0),
                  )),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
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
                    height: height / 3,
                    width: width / 2,
                    child: priceCard(context),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
