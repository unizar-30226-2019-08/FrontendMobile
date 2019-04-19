/*
 * FICHERO:     user_profile.dart
 * DESCRIPCIÓN: clases relativas al la página personal de un usuario
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/objects_generator.dart';

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
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
                length: 2,
                child: Scaffold(
                    appBar: ProfileNavbar(
                        preferredSize: Size.fromHeight(height / 3.3),
                        user: generatePseudoUser(snapshot.data)),
                    body: TabBarView(
                      children: [
                        Column(
                          children: <Widget>[
                            MiniProduct(generateRandomProduct()),
                            MiniProduct(generateRandomProduct()),
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            ReviewCard(
                                generateRandomUser(),
                                DateTime.utc(2019, 03, 9),
                                false,
                                generateRandomProduct(),
                                lipsum.createParagraph(numSentences: 3),
                                8.4),
                            ReviewCard(
                                generateRandomUser(),
                                DateTime.utc(2019, 02, 15),
                                true,
                                generateRandomProduct(),
                                lipsum.createParagraph(numSentences: 3),
                                2)
                          ],
                        )
                      ],
                    )));
          } else {
            return Scaffold(body: BookaloProgressIndicator());
          }
        });
  }
}
