/*
* FICHERO:     user_view.dart
* DESCRIPCIÓN: visor de los datos del usuario en la ventana de producto
*              detallado
* CREACIÓN:    07/03/2019
*
 */


import 'package:flutter/material.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/translations.dart';




/*
  CLASE: UserProduct
  DESCRIPCIÓN: widget que muestra la información del
            usuario vendedor en la página de producto detallado
 */

  class UserProduct extends StatefulWidget {
    //TODO: ver atributos

    UserProduct();
    _UserProductState createState() => _UserProductState();

  }




class _UserProductState extends State<UserProduct> {
  User usuario=User('Silvia M.',
      'https://secure.gravatar.com/avatar/b10f7ddbf9b8be9e3c46c302bb20101d?s=400&d=mm&r=g'); //TODO: ver como inicializarlo

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16,top: 16),
              child: Text(
                Translations.of(context).text("offered"),
                style: TextStyle(height: 1.0, fontSize: 22,fontWeight: FontWeight.bold),
              )
            ),
            ListTile(
              isThreeLine: false,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(usuario.getImagenPerfil()),
              ),
              title: Text(usuario.getName()),
              subtitle: StaticStars(
                 /* usuario.getRating()*/6,
                  Colors.black,
                  /*usuario.getReviews()*/6),//Todo: rating y reviews
            ),
          ],
        ),
    );
  }
}