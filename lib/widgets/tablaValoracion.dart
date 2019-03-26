import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart'; 


/*
@override
  Widget buildStars(BuildContext context, int index) {
    IconButton icono;
    if(index>=decimal_r){
      icono = new IconButton(
          icon:Icon(Icons.star_border),
          color: color
      );
    } else{
      icono = new IconButton(
          icon:Icon(Icons.star),
          color: color
          onPressed:_puntuar,
      );
    }

    return icono;
}*/


typedef OnDelete();
class ValorationCard extends StatefulWidget {
  final String coment;
   
  final OnDelete onDelete;
   final state= _ValorationCardState();
   ValorationCard({this.coment,this.onDelete});
 // ValorationCard();
  _ValorationCardState createState() => state;
  bool isValid()=>state.validate();
  
}

class _ValorationCardState extends State<ValorationCard>{
   double rating=3.0;
    final _formKey = GlobalKey<FormState>();
  _ValorationCardState();


@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child:Card(
        child:Form(
          key:_formKey,
         child: Column(
           mainAxisSize:MainAxisSize.min ,
          children: <Widget>[
            AppBar(
              title:Text( "Valora al usuario",),
              centerTitle: true,
              backgroundColor: Colors.pink,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("¿Qué te ha parecido este usuario?",
                        style: TextStyle(height: 1.0,fontSize: 20))],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:TextFormField(
                initialValue: "Danos tu opinion",
                validator: (value) {
                  if (value.isEmpty) {
                      return 'No puedes dejar este campo vacio';
                    }
                  },

              )
            ),
             Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child:Row(
              
              children:[new StarRating(
               size: 25.0,
                rating: rating,
                color: Colors.orange,
                  borderColor: Colors.grey,
                starCount:5,
                onRatingChanged: (rating) => setState(
                    () {
                      this.rating = rating;
                    },
                  ),
            ),
          ]
          ),
          ),




            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: IconButton(
                icon:Icon(Icons.check_circle) ,
                iconSize: 50,
                color: Colors.green,
                onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                  if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
              //child: Text("Confirmar"),
            ),
            ),

         

          ]
            )

        ),
      )
    );
  }

  bool validate(){
    var valid=_formKey.currentState.validate();
    if(valid)_formKey.currentState.save();
    return valid;
  }




}













    /*return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color:Colors.pink,
      child:Column(
        children:[
          Row(
            children: [Text("¿Qué te ha parecido este usuario?")],
          ),
          Row(
            children:[new StarRating(
              size: 25.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount:5,
              onRatingChanged: (rating) => setState(
                    () {
                      this.rating = rating;
                    },
                  ),
            ),
          ]
          ),
          Row(
            children:[ TextFormField(validator: (value) {
                  if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                )
              ]
            ),
          Row(children:[
              RaisedButton(
                  onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                        }
                    },
                    child: Icon(Icons.check_circle),
                    //Text("Confirmar"),
                )
           ] ),
        ]
      )
    );
  }*/







/*
Row(
            children:[new StarRating(
              size: 15.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount:5,
              onRatingChanged: (rating) => setState(
                    () {
                      this.rating = rating;
                    },
                  ),
            ),
          ]
          ),


*/


/*
              children:[FlatButton(
                onPressed: () => {},
                color: Colors.pink,
                padding: EdgeInsets.all(10.0),
                child: Row( 
                  children: <Widget>[
                    Icon(Icons.check_circle),
                    Text("Confirmar")
                  ],
                ),
            )
              ]
          )
            ],
          )

    );
}
}*/
  




