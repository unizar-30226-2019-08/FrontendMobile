import 'package:flutter/material.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart'; 

class EstrellasValoracion extends StatefulWidget {
  EstrellasValoracion();

  _EstrellasValoracionState createState() => _EstrellasValoracionState();
  
}
typedef void RatingChangeCallback(double rating);
class _EstrellasValoracionState extends State<EstrellasValoracion>{
    
    //_EstrellasValoracionState({this.color,this.valoracion});

final Color color;
 final int estrellas;
  final double valoracion;
  final RatingChangeCallback onRatingChanged;

  _EstrellasValoracionState({this.estrellas = 5, this.valoracion = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= valoracion) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    }
    else if (index > valoracion - 1 && index < valoracion) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(estrellas, (index) => buildStar(context, index)));
  }
}

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



class TablaValoracion extends StatelessWidget{
  final String comentario;
  final String texto;
  TablaValoracion({Key key,
    this.comentario,this.texto}): super(key: key);


@override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.pink,
      child:Column(
        children:[
          Row(
            children: [Text("¿Qué te ha parecido este usuario?")],
          ),
          Row(
            children:[EstrellasValoracion()],
          ),
          Row(
            children:[TextField()]
            ),
          Row(
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
}
