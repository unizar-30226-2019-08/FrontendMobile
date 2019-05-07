/*
 * FICHERO:     buy.dart
 * DESCRIPCIÓN: clases relativas al la pestaña de compra
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:bookalo/utils/product_paging.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/filter.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/social_buttons.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/widgets/filter_options_selector.dart';
import 'package:bookalo/utils/http_utils.dart';

/*
 *  CLASE:        Buy
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de compra. Contiene una lista con los productos
 *                obtenidos según las opciones de filtrado.
 */
class Buy extends StatefulWidget {
  Buy({Key key}) : super(key: key);

  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  bool endReached = false;
  bool firstFetch = true;

  @override
  void initState() { 
    super.initState();
    ScopedModel.of<FilterQuery>(context).queryResult.clear();
  }

  Future<List<Widget>> fetchProducts(currentSize, height, FilterQuery query) async{
    List<Widget> output = new List();
    if(!endReached){
      Tuple2<List<ProductView>, bool> fetchResult = await parseProducts(query, currentSize);
      endReached = fetchResult.item2;
      output.addAll(fetchResult.item1);
      if(endReached){
        if(firstFetch){
         output.add(
           Container(
             margin: EdgeInsets.only(top: 200.0),
             child: Column(
               children: <Widget>[
                 Icon(Icons.remove_shopping_cart, size: 80.0, color: Colors.pink),
                 Text(
                   Translations.of(context).text('no_products_available'),
                   style: TextStyle(
                     fontSize: 25.0,
                     fontWeight: FontWeight.w300
                   ),
                 )
               ],
             ),
           )
         ); 
        }else{
          output.add(SocialButtons());
        }
      }
    }
    if(firstFetch){
      firstFetch = false;
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: "searchFAB",
              icon: Icon(Icons.search),
              label: Text(Translations.of(context).text('search')),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Filter())
                // );
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            FloatingActionButton.extended(
              heroTag: "filterFAB",
              icon: Icon(Icons.sort),
              label: Text(Translations.of(context).text('filter')),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Filter()));
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            FilterOptionSelector(),
            Expanded(
              child: ScopedModelDescendant<FilterQuery>(
                builder: (context, child, model){     
                  return ProductPagination<Widget>(
                    progress: Container(
                        margin: EdgeInsets.symmetric(vertical: height / 20),
                        child: BookaloProgressIndicator()),
                    pageBuilder: (currentSize) => fetchProducts(currentSize, height, model),
                    itemBuilder: (index, item) {
                      return item;
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
