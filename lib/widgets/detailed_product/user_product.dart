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
import 'package:bookalo/pages/user_profile.dart';
import 'package:bookalo/pages/chat.dart';

/*
  CLASE: UserProduct
  DESCRIPCIÓN: widget que muestra la información del
            usuario vendedor en la página de producto detallado
 */

class UserProduct extends StatelessWidget {
  final User _user;

  UserProduct(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(
                Translations.of(context).text("offered"),
                style: TextStyle(
                    height: 1.0, fontSize: 22, fontWeight: FontWeight.bold),
              )),
          ListTile(
            isThreeLine: false,
            leading: Hero(
              tag: "profileImage",
              child: CircleAvatar(
                backgroundImage: NetworkImage(_user.getPicture()),
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.pink,
                size: 40.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat()),
                );
              },
            ),
            title: Text(_user.getName()),
            subtitle: StaticStars(
                /* usuario.getRating()*/ 6,
                Colors.black,
                /*usuario.getReviews()*/ 6), //Todo: rating y reviews
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProfile(isOwnProfile: false)),
              );
            },
          ),
        ],
      ),
    );
  }
}
