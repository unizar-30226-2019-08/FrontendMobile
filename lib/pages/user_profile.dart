/*
 * FICHERO:     user_profile.dart
 * DESCRIPCIÓN: clases relativas al la página personal de un usuario
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/user.dart';
/*
 *  CLASE:        UserProfile
 *  DESCRIPCIÓN:  widget para el cuerpo principal del visor de perfiles
 *                de usuario. Contiene información del usuario (en la navbar)
 *                y dos pestañas: una para productos en venta y otra para opiniones
 */
class UserProfile extends StatefulWidget {

  UserProfile();

  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ProfileNavbar(preferredSize: Size.fromHeight(height/3.3)),
        body: TabBarView(
          children: [
            //Icon(Icons.ac_unit),
            Column(
              children: <Widget>[
                MiniProduct(new Product('Fundamentos de álgebra', 10, true, 'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg', "")),
                MiniProduct(new Product('Lápiz', 0.75, false, 'https://www.kalamazoo.es/content/images/product/31350_1_xnl.jpg', "")),
              ],
            ),

            //Icon(Icons.access_alarms),
            ListView(
              children: <Widget>[
                ReviewCard(User('Silvia M.','https://secure.gravatar.com/avatar/b10f7ddbf9b8be9e3c46c302bb20101d?s=400&d=mm&r=g'),
                    DateTime.utc(2019, 03, 9),false, new Product('Libro', 9.5, true,
                        'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg', ""),
                    'Muy buen vendedor', 8.4),
                ReviewCard(User('Laura P.','https://media.nngroup.com/media/people/photos/Kim-Flaherty-Headshot.png.400x400_q95_autocrop_crop_upscale.png'),
                    DateTime.utc(2019, 02, 15),true, new Product('Libro', 9.5, true,
                        'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg', ""),
                    'No fue puntual.---Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non maximus risus. Curabitur et felis ex. Aliquam erat volutpat. Donec sit amet ullamcorper ante. Maecenas at mauris at odio ultricies eleifend. In mollis leo odio. Nunc laoreet, lectus non porttitor pharetra, felis libero ultrices libero, et aliquet sem metus id purus. Donec id lectus nisi. Mauris sed fringilla leo. Sed ullamcorper feugiat tincidunt. Mauris faucibus fringilla neque, at maximus ligula. Donec non tellus magna.', 2)
              ],

            )

          ],
        )
      ),
    );
  }
}