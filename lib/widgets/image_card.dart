/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/report.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/pages/chat.dart';
import 'package:bookalo/widgets/distance_chip.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/objects_generator.dart';
import 'package:geo/geo.dart';
import 'dart:io';


/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ImageCard extends StatelessWidget {
  final File image; //usuario actual
  final Function (File) removePicture;
  ImageCard(this.image,this.removePicture);//(this.erasePicture);//({this.image});

   
  
  @override
  Widget build(BuildContext context) {





    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int i;

    //Eliminar producto al pulsar la X
   onXpressed(){
    AlertDialog removeWarning =AlertDialog(title:Text(Translations.of(context).text("Warning")),content:Text(Translations.of(context).text("confirmation_text")),
    actions:[
        new FlatButton(onPressed:(){ removePicture(this.image);Navigator.pop(context);},child:Text(Translations.of(context).text("Continue"))),
        new FlatButton(onPressed:(){Navigator.pop(context);},child:Text(Translations.of(context).text("Cancel"),)),
    ]
    );
    showDialog(context: context,builder:(BuildContext context){return removeWarning;});
   // erasePicture();
  }


   return Column(
          children:[
               Container(
                 width:width/1.5,
                 height:height/2,
                 child:
                Padding(
        padding: EdgeInsets.all(5),
        child:Card(
          color:Colors.grey,
      child: InkWell(
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
       


        child:Image.file(this.image)
        ),
      ),
    ),
),
   IconButton(icon:Icon(Icons.cancel),onPressed:(){onXpressed();})//{showDialog(context: context,builder: (BuildContext context){return removeWarning;});})
 
          


              ]
   );
   
  







   /*return Column(
          children:[
               Container(
                 width:width,
                 height:height,
                 child:
                Padding(
        padding: EdgeInsets.all(5),
        child:Card(
          
      child: Image(image:FileImage(image)),
      ),
    ),
),
          ]
   );*/
  
  








    /*return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(alignment: Alignment.topRight, children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:FileImage(image),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ]
        )
    );*/









    /*return Padding(
        
        padding: EdgeInsets.all(10),
        child: Card(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          
          child: Image.file(this.image,width:width,
                          height:height)
            
        ));*/
  }
  

  
}
