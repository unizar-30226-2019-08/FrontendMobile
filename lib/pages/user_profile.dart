/*
 * FICHERO:     user_profile.dart
 * DESCRIPCIÓN: clases relativas a la página personal de un usuario
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/list_viewer.dart';
import 'package:bookalo/utils/objects_generator.dart';
import 'package:bookalo/objects/user.dart';

/*
 *  CLASE:        UserProfile
 *  DESCRIPCIÓN:  widget para el cuerpo principal del visor de perfiles
 *                de usuario. Contiene información del usuario (en la navbar)
 *                y dos pestañas: una para productos en venta y otra para opiniones
 */
class UserProfile extends StatefulWidget {
  final bool isOwnProfile;

  UserProfile({Key key, this.isOwnProfile}) : super(key: key);

  _UserProfileState createState() => _UserProfileState();
}

//TODO: clase page_view que encapsule list.builder??
//TODO: _fetch page con productos o con widget visor??
class _UserProfileState extends State<UserProfile> {
  /*
      Pre: pageNumber >=0 y pageSize > 0
      Post: devuelve una lista con pageSize ProductView
   */
  _fetchFeatured(int pageNumber, int pageSize) async {
    await Future.delayed(
        Duration(seconds: 1)); //TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      if (index % 2 == 0) {
      /*  return ProductView(
            Product('Fundamentos álgebra', 12, false,
                'https://placeimg.com/640/480/any', ""),
            6.1,
            39);
      } else {
        return ProductView(
            Product('Lengua castellana', 3, true,
                'https://placeimg.com/640/480/any', ""),
            6.1,
            39);*/
      }
    });
  }

  /*
      Pre: ---
      Post: devuelve una ListView con la lista de elementos en page
   */
  Widget _buildPage(List page) {
    return ListView(shrinkWrap: true, primary: false, children: page);
  }

  /*
      Pre:---
      Post: devuelve una listView de productos destacados con product view
   */

  Widget _featuredProducts(bool isOwnProfile) {
    return ListView.builder(
      itemBuilder: (context, pageNumber) {
        return KeepAliveFutureBuilder(
          future: this._fetchFeatured(pageNumber, 3), //TODO: cambiar función
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
                }
                break;
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
  _fetchReviews(String uid, int pageNumber, int pageSize) async {
    await Future.delayed(
        Duration(seconds: 1)); //TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      if (index % 2 == 0) {
        return ReviewCard(
            generateRandomUser(),
            DateTime.utc(2019, 03, 9),
            false,
            generateRandomProduct(),
            lipsum.createSentence(numSentences: 3),
            8.4);
      } else {
        return ReviewCard(
            generateRandomUser(),
            DateTime.utc(2019, 02, 15),
            true,
            generateRandomProduct(),
            lipsum.createSentence(numSentences: 2),
            2);
      }
    });
  }

  /*
      Pre:---
      Post: devuelve una listView de  valoraciones con ReviewCard
   */

  Widget _userReviews(User user) {
    return ListView.builder(
      itemBuilder: (context, pageNumber) {
        return KeepAliveFutureBuilder(
          future: this._fetchReviews(user.getUID(), pageNumber, 4),
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
                }
                break;
              case ConnectionState.active:
            }
          },
        );
      },
    );
  }

  Future<User> getUser(bool isOwnProfile) async {
    if (isOwnProfile) {
      return generatePseudoUser(await FirebaseAuth.instance.currentUser());
    } else {
      return generateRandomUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<User>(
        future: getUser(widget.isOwnProfile),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
                length: 2,
                child: Scaffold(
                    appBar: ProfileNavbar(
                        preferredSize: Size.fromHeight(height / 3.3),
                        user: snapshot.data,
                        isOwnProfile: widget.isOwnProfile),
                    body: TabBarView(
                      children: [
                        _featuredProducts(widget.isOwnProfile),
                        _userReviews(snapshot.data)
                      ],
                    )));
          } else {
            return Scaffold(body: BookaloProgressIndicator());
          }
        });
  }
}
