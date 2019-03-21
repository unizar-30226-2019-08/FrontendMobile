import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/static_stars.dart';

class VisorProducto extends StatelessWidget{
  final Product _producto;
  final double _estrellas;
  final int _valoraciones;


  VisorProducto(this._producto, this._estrellas, this._valoraciones);

  Widget tarjeta1(BuildContext context){
    return Card(  //Tarjeta 1
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16,top: 16, bottom: 8),
                child: Text(
                    _producto.precioToString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, bottom: 8),
            child:  Text(this._producto.getNombre(),
              textAlign: TextAlign.justify, //TODO:descripcion
              maxLines: 5,    //TODO: ver maximo de lineas
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: StaticStars(this._estrellas, Colors.black,this._valoraciones),
          )
        ],
      ),
    );
  }

  Widget tarjeta2(BuildContext context){
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Image.asset( //TODO:network no funciona
                'assets/images/product_picture.jpg',
                //this._producto.getImagen(),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                //width: MediaQuery.of(context).size.width,
               // margin:EdgeInsets.all(10),
                child: ListTile(
                  title: Text(this._producto.getNombre(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                     // fontSize: 40,
                    ),
                  ),
                  trailing: Icon(Icons.chat_bubble, size: 40,),
                )
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      //todo: obtener dimensiones
      double width=MediaQuery.of(context).size.width* 0.7;
      double height= MediaQuery.of(context).size.height*0.7;
     /* return Container(
        width: width,
        height: height,
        color: Colors.green,
        margin: EdgeInsets.all(30),
        child:

      );*/


     /* return  Stack(
       // fit: StackFit.loose,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: width *0.5,top: height*0.01),
            height: height*0.65,
            width: width*0.75,
            child: tarjeta2(context),
          ),
          Container(
            margin: EdgeInsets.only(top: height *0.1),
            height: height*0.45,
            width: width*0.65,
            child: tarjeta1(context),
          )

        ],
      );*/

     return  Stack(
       // fit: StackFit.loose,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: width *0.5,top: height*0.01),
            height: height*0.65,
            width: width*0.75,
            child: tarjeta2(context),
          ),
          Container(
            margin: EdgeInsets.only(top: height *0.1),
            height: height*0.45,
            width: width*0.65,
            child: tarjeta1(context),
          )

        ],
      );
  }




}




