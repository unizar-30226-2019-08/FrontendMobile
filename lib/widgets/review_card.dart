/*
 * FICHERO:     review_card.dart
 * DESCRIPCIÓN: miniatura de valoracion de transacción
 * CREACIÓN:    15/03/2019
 *
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/review.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/utils/dates_utils.dart';
import 'package:bookalo/translations.dart';

/*
  CLASE: ReviewCard
  DESCRIPCIÓN: widget de miniatura de transaccion
 */
class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(review.getReviewer.getPicture())),
              title: Text(review.getReviewer.getName(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                  )),
              subtitle: Text(
                //TODO: apañar etiqueta
                Translations.of(context).text("seller_tab"),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 17,
                ),
              ),
              trailing: CircleAvatar(
                  backgroundImage:
                      NetworkImage(review.getProduct.getImages()[0])),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                        dateToNumbers(review.getDate, context), //DateToString
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 19,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: StaticStars(review.getStars, Colors.black, null),
                  )
                ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
                  child: Text(
                    review.getReview,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ), //TODO: expandablePanel
                )
              ],
            )
          ],
        ),
      ),
    );

    // return null;
  }
}
