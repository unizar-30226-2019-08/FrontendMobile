/*
 * FICHERO:     user_profile.dart
 * DESCRIPCIÓN: clases relativas a la página personal de un usuario
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/review_card.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';
import 'package:bookalo/widgets/navbars/own_profile_navbar.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/product_view.dart';

/*
 *  CLASE:        UserProfile
 *  DESCRIPCIÓN:  widget para el cuerpo principal del visor de perfiles
 *                de usuario. Contiene información del usuario (en la navbar)
 *                y dos pestañas: una para productos en venta y otra para opiniones
 */
class UserProfile extends StatefulWidget {
  final bool isOwnProfile;
  final User user;

  UserProfile({Key key, this.isOwnProfile, this.user}) : super(key: key);

  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: (widget.isOwnProfile
                ? OwnProfileNavbar(preferredSize: Size.fromHeight(height / 3.3))
                : ProfileNavbar(
                    preferredSize: Size.fromHeight(height / 3.3),
                    user: widget.user)),
            body: TabBarView(
              children: [
                FeaturedProducts(
                    isOwnProfile: widget.isOwnProfile, user: widget.user),
                ReviewViewer(user: widget.user),
              ],
            )));
  }
}

class FeaturedProducts extends StatefulWidget {
  final bool isOwnProfile;
  final User user;
  FeaturedProducts({Key key, this.isOwnProfile, this.user}) : super(key: key);

  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  bool featuredEndReached = false;
  bool featuredFirstFecth = true;

  Future<List<Widget>> fetchUserProducts(currentSize, height) async {
    List<Widget> output = new List();
    if (!featuredEndReached) {
      List<ProductView> fetchResult = widget.isOwnProfile
          ? await parseUserFavorites(currentSize, 10)
          : await parseUserProducts(widget.user, currentSize, 10);
      featuredEndReached = fetchResult.length == 0;
      output.addAll(fetchResult);
      if (featuredEndReached) {
        if (featuredFirstFecth) {
          output.add(Container(
            margin: EdgeInsets.only(top: 150.0, left: 70.0, right: 70.0),
            child: Column(
              children: <Widget>[
                Icon(
                    widget.isOwnProfile
                        ? Icons.favorite_border
                        : Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Colors.pink),
                Text(
                  widget.isOwnProfile
                      ? Translations.of(context).text('no_favorites_yes')
                      : Translations.of(context).text('no_productos_uploaded'),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ));
        }
      }
      if (featuredFirstFecth) {
        featuredFirstFecth = false;
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Pagination<Widget>(
      progress: Container(
          margin: EdgeInsets.symmetric(vertical: height / 20),
          child: BookaloProgressIndicator()),
      pageBuilder: (currentSize) => (widget.isOwnProfile
          ? fetchUserProducts(currentSize, height)
          : fetchUserProducts(currentSize, height)),
      itemBuilder: (index, item) {
        return item;
      },
    );
  }
}

class ReviewViewer extends StatefulWidget {
  final User user;
  ReviewViewer({Key key, this.user}) : super(key: key);
  @override
  _ReviewViewerState createState() => _ReviewViewerState();
}

class _ReviewViewerState extends State<ReviewViewer> {
  bool reviewsEndReached = false;
  bool reviewsFirstFecth = true;

  Future<List<Widget>> fetchReviews(currentSize, height) async {
    List<Widget> output = new List();
    if (!reviewsEndReached) {
      List<ReviewCard> fetchResult =
          await parseReviews(currentSize, 10, user: widget.user);
      reviewsEndReached = fetchResult.length == 0;
      output.addAll(fetchResult);
      if (reviewsEndReached) {
        if (reviewsFirstFecth) {
          output.add(Container(
            margin: EdgeInsets.only(top: 150.0, left: 70.0, right: 70.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.rate_review, size: 80.0, color: Colors.pink),
                Text(
                  Translations.of(context).text('no_reviews_yet'),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ));
        }
      }
      if (reviewsFirstFecth) {
        reviewsFirstFecth = false;
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Pagination<Widget>(
      progress: Container(
          margin: EdgeInsets.symmetric(vertical: height / 20),
          child: BookaloProgressIndicator()),
      pageBuilder: (currentSize) => fetchReviews(currentSize, height),
      itemBuilder: (index, item) {
        return item;
      },
    );
  }
}
