/*
 * FICHERO:     mini_product.dart
 * DESCRIPCIÓN: visor de miniatura del producto
 * CREACIÓN:    15/03/2019
 */

import 'package:bookalo/translations.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';


/*
  CLASE: MiniProduct
  DESCRIPCIÓN: widget de miniatura de producto
 */

class MiniProduct extends StatelessWidget{
  final Product _product;

  MiniProduct(this._product);

/*
  Pre:---
  Post: devuelve un Widget con el precio del producto y el tag de vendido
        si el producto se ha vendido
 */

  Widget priceBody(BuildContext context){
    Widget b;
    if(_product.getSold()){
      b = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(Translations.of(context).text("sold_tab"),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                )
            ),
           ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              _product.priceToString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )

        ],
      );
    }else{
      b = Container(
        margin: EdgeInsets.only(left: 20),
          child: Text(
            _product.priceToString(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
      );
    }
    return b;
  }

 @override
  Widget build(BuildContext context) {
   return Container(
       padding: const EdgeInsets.all(4.0),
       decoration: new BoxDecoration(
           border: new Border.all(color: Colors.grey[400],width: 0.4)
       ),
       child: ListTile(
        leading:CircleAvatar(backgroundImage: NetworkImage(this._product.getImage())),
        title:Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  this._product.getName(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),
                ),
              ),
              priceBody(context),
            ],
          ),
        ),
        isThreeLine: false,
        enabled: true,
        //trailing:PriceBody(context),
        dense:true,
   )
   );

  }

}