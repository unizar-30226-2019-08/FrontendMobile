import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/usuario.dart';
import 'package:bookalo/widgets/static_stars.dart';


class MiniaturaValoracion extends StatelessWidget{
  final Usuario _usuario;
  final int _fechaValoracion;
  final bool _vendio;//Falso:compró
  //TODO: numero de valoraciones en usuario??
  final Product _producto;
  final String _valoracion;
  final double _estrellas;


  MiniaturaValoracion(this._usuario, this._fechaValoracion, this._vendio,
      this._producto, this._valoracion, this._estrellas);

  String accion(){
    if(this._vendio){
      return "vendió";
    }else{return "compró";}
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
              subtitle: Text(this._vendio ? "vendió" : "compró", //TODO: no funciona comprar/vender
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 17,
                ),
              ),
              trailing:CircleAvatar(backgroundImage: NetworkImage(_producto.getImagen())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children :[
                Container(
                  margin:EdgeInsets.only(left: 20),
                  child: Text('FECHA',
                    style:TextStyle(
                      color: Colors.grey[400],
                      fontSize: 19,
                    )),),
                StaticStars(this._estrellas, Colors.black, 39),
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                   child: Text(this._valoracion, //TODO: como poner parrafos??s
                      textAlign: TextAlign.left,
                    )
                )
              ],
            )

          ],
        ),
      );


   // return null;
  }



}