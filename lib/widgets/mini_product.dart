import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';

class MiniProduct extends StatelessWidget{
  final Product producto;

  MiniProduct(this.producto);

 @override
  Widget build(BuildContext context) {
   double height = MediaQuery.of(context).size.height;
   double width = MediaQuery.of(context).size.width;
    return Container(
      height: height/10,
      width: width,
      child: Row(
        children:[
          Container( //Imagen producto
            width: width/5,
            padding: const EdgeInsets.all(8.0),
            //padding: EdgeInsets.fromLTRB(width*0.05, (height/10)*0.05, width*0.05, (height/10)*0.05),
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(producto.getImagen()),
              )
            ),
          ),
          Container(
            width: (width/5)*2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(producto.getNombre(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('VENDIDO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
        ),
        ],
      ),

    )
    ;
  }

}