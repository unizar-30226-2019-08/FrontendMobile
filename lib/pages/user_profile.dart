/*
 * FICHERO:     user_profile.dart
 * DESCRIPCIÓN: clases relativas a la página personal de un usuario
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/list_viewer.dart';
import 'package:geo/geo.dart';

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

//TODO: clase page_view que encapsule list.builder??
//TODO: _fetch page con productos o con widget visor??
class _UserProfileState extends State<UserProfile> {

  /*
      Pre: pageNumber >=0 y pageSize > 0
      Post: devuelve una lista con pageSize ProductView
   */
  _fetchFavorites(int pageNumber, int pageSize) async{
    await Future.delayed(Duration(seconds: 1));//TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      if(index%2==0){
        return  ProductView(
            Product('Fundamentos álgebra', 12, "Nuevo",
                "En Venta", LatLng(0,0), false, "Descripcion",
                2,['https://placeimg.com/640/480/any']),
            6.1,
            39);
      }else{
        return ProductView(
            Product('Lengua castellana', 3, "Nuevo",
                "En Venta", LatLng(0,0), false, "Descripcion",
                2,['https://placeimg.com/640/480/any']),
            6.1,
            39);
      }
    });

  }

  /*
      Pre: ---
      Post: devuelve una ListView con la lista de elementos en page
   */
  Widget _buildPage(List page) {
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: page
    );
  }

  /*
      Pre:---
      Post: devuelve una listView de productos favoritos con product view
   */

  Widget _favoriteProducts(){
    return ListView.builder(
      itemBuilder: (context,pageNumber){
        return KeepAliveFutureBuilder(
          future: this._fetchFavorites(pageNumber, 3),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: BookaloProgressIndicator(),
                );
              case ConnectionState.waiting:
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: BookaloProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return this._buildPage(snapshot.data);
                }break;
              case ConnectionState.active:
            }
          },
        );
      },
    );
  }


  /*
      Pre: pageNumber >=0 y pageSize > 0
      Post: devuelve una lista con pageSize ReviewCard
   */
  _fetchReviews(int pageNumber, int pageSize) async {
    await Future.delayed(
        Duration(seconds: 1)); //TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      if (index % 2 == 0) {
        return ReviewCard(
            User('Silvia M.',
                'https://secure.gravatar.com/avatar/b10f7ddbf9b8be9e3c46c302bb20101d?s=400&d=mm&r=g'),
            DateTime.utc(2019, 03, 9),
            false,
            new Product(
                'Libro',
                9.5,
                "Nuevo",
                "En Venta", LatLng(0,0), false, "Descripcion",
                2,['https://placeimg.com/640/480/any']),
            'Muy buen vendedor',
            8.4);
      } else {
        return ReviewCard(
            User('Laura P.',
                'https://media.nngroup.com/media/people/photos/Kim-Flaherty-Headshot.png.400x400_q95_autocrop_crop_upscale.png'),
            DateTime.utc(2019, 02, 15),
            true,
            new Product(
                'Libro',
                9.5,
                "Nuevo",
                "En Venta", LatLng(0,0), false, "Descripcion",
                2,['https://placeimg.com/640/480/any']),
            'No fue puntual.---Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non maximus risus. Curabitur et felis ex. Aliquam erat volutpat. Donec sit amet ullamcorper ante. Maecenas at mauris at odio ultricies eleifend. In mollis leo odio. Nunc laoreet, lectus non porttitor pharetra, felis libero ultrices libero, et aliquet sem metus id purus. Donec id lectus nisi. Mauris sed fringilla leo. Sed ullamcorper feugiat tincidunt. Mauris faucibus fringilla neque, at maximus ligula. Donec non tellus magna.',
            2);
      }
    });
  }

  /*
      Pre:---
      Post: devuelve una listView de  valoraciones con ReviewCard
   */

  Widget _userReviews(){
    return ListView.builder(
      itemBuilder: (context,pageNumber){
        return KeepAliveFutureBuilder(
          future: this._fetchReviews(pageNumber, 4),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: BookaloProgressIndicator(),
                                  );
              case ConnectionState.waiting:
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: BookaloProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return this._buildPage(snapshot.data);
                }break;
              case ConnectionState.active:
            }
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: ProfileNavbar(preferredSize: Size.fromHeight(height / 3.3)),
          body: TabBarView(
            children: [
              _favoriteProducts(),
              _userReviews()
            ],
          )),
    );
  }
}

