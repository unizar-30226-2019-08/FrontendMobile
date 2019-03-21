import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';

class MiniProduct extends StatelessWidget{
  final Product producto;

  MiniProduct(this.producto);



  Widget cuerpo(BuildContext context){
    Widget b;
    if(producto.getVendido()){
      b=new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text('VENDIDO',//TODO:Translations.of(context).text("sold")
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
              producto.precioToString(),
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
          b=new Container(
            margin: EdgeInsets.only(left: 20),
              child: Text(
                producto.precioToString(),
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
     leading:CircleAvatar(backgroundImage: NetworkImage(this.producto.getImagen())),
     title:Container(
       margin: EdgeInsets.all(10),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Text(
             this.producto.getNombre(),
             style: TextStyle(
               color: Colors.black,
               fontSize: 19,
             ),
           ),
           cuerpo(context),
         ],
       ),
     ),
     isThreeLine: false,
     enabled: true,
     //trailing:cuerpo(context),
     dense:true,
   )
   );

  }

}