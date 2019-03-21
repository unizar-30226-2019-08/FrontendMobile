import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/usuario.dart';
import 'package:bookalo/widgets/static_stars.dart';


class MiniaturaValoracion extends StatelessWidget{
  final Usuario _usuario;
  //final int _fechaValoracion;
   var _fechaValoracion;
  final bool _vendio;//Falso:compró
  //TODO: numero de valoraciones en usuario??
  final Product _producto;
  final String _valoracion;
  final double _estrellas;


  MiniaturaValoracion(this._usuario, this._fechaValoracion, this._vendio,
      this._producto, this._valoracion, this._estrellas);

  String fecha(DateTime f){
    String res=(f.day).toString()+'/'+(f.month).toString()+'/'+(f.year).toString();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(_usuario.getImagenPerfil())),
              title: Text(_usuario.getNombre(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                  )
                ),
              subtitle: Text(this._vendio == true ? "vendió" : "compró",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 17,
                ),
              ),
              trailing:CircleAvatar(backgroundImage: NetworkImage(_producto.getImagen())),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children :[
                Container(
                  margin:EdgeInsets.only(left: 16),
                  child: Text(fecha(_fechaValoracion),  //fecha
                    style:TextStyle(
                      color: Colors.grey[400],
                      fontSize: 19,
                    )
                  ),
                ),
               Container(
                 padding: EdgeInsets.only(right: 16),
                 child: StaticStars(this._estrellas, Colors.black,null),
               )

              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 16,right: 16, bottom: 20,top: 10),
                    child:  Text(this._valoracion,
                      textAlign: TextAlign.justify,
                      maxLines: 5,    //TODO: ver maximo de lineas
                      overflow: TextOverflow.ellipsis,
                    ),

                  )
                ],
            )

          ],
        ),
      );


   // return null;
  }



}