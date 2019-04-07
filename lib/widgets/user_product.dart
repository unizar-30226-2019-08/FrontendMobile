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
  CLASE: ProductView
  DESCRIPCIÓN: widget de vista de producto de la pantalla principal
 */
/*
  class UserProduct extends StatefulWidget {
    //TODO: ver atributos

  UserProduct();
  _UserProduct createState() => _UserProduct();

}

  class _UserProduct extends State<UserProduct>{
  User usuario; //TODO: ver como inicializarlo
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(Translations.of(context).text("offered")
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(usuario.getImagenPerfil()),
            ),
          title: Text(usuario.getName()),
          subtitle: StaticStars(usuario.getRating(), Colors.black, usuario.getReviews()),
        ),
      ],
    );
  }

  }
  */
class UserProduct extends StatelessWidget {
  User usuario; //TODO: ver como inicializarlo

  UserProduct(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Text(Translations.of(context).text("offered")
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(usuario.getImagenPerfil()),
              ),
              title: Text(usuario.getName()),
              subtitle: StaticStars(
                  usuario.getRating(), Colors.black, usuario.getReviews()),
            ),
          ],
        ),
    );
  }
}