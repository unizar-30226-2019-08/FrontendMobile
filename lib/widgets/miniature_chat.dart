import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:holii/Objects/usuario.dart';
import 'package:holii/Objects/product.dart';
import 'package:intl/intl.dart';


class MiniatureChat extends StatelessWidget {
  final Usuario user; //Usuario con el que se chatea
  final Product product;    //Producto sobre el que trata el chat
  final bool author;        //vale true si el usuario es el autor ddel ultimo mensaje
  final String lastMessage;   //ultimo mensaje enviado en el chat
  final bool buying;          //vale true si el chat es para comprar un producto y false si es para venderlo
  final bool closed;         //vale true si la transacción está cerrada
  final DateTime lastTimeDate;     //indica la fecha de la última conexión
  //final EdgeInsetsGeometry padding;
 // final Color color;
  MiniatureChat({Key key,this.user,this.product,this.author,this.lastMessage,this.buying,this.closed,
  this.lastTimeDate}): super(key: key);


  /*Pre:lastCon no puede representar una fecha posterior a la actual
  *Post:Devuelve un string que indica la fecha de la ultima conexión.
  */
  Text lastConection(DateTime lastCon){
    String aMostrar=DateFormat('kk:mm').format(lastCon);
    var fechaActual=new DateTime.now();
    var diferencia=fechaActual.difference(lastCon);
    
    if(diferencia.inDays==1){
      aMostrar='Ayer '+ aMostrar;
    }
    else if(diferencia.inDays==0 ){
      aMostrar='Hoy '+ aMostrar;
    }
    else if(diferencia.inDays>1){
      aMostrar=DateFormat().format(lastCon);
    }
    return Text(aMostrar);
  }

  /*Pre:
  *Post:Construye el título de la miniatura con último mensaje y su autor
  */
  Text buildTitle(){
    String message="";
    String autor="";
    if(this.lastMessage.length>10){
      message=this.lastMessage.substring(1,10)+"...";
    }
    else{
      message=this.lastMessage;
    }

    if(author){
        autor="Tu";
    }
    else{
      this.user.getNombre();
    }
    String aMostrar=autor+': '+message;
    return Text(aMostrar);
  }

  Widget title(BuildContext context){
    Widget b;
    if(closed){
      b=new Row(
        children:<Widget>[
          buildTitle(),
          DecoratedBox(
            decoration:BoxDecoration(color:Colors.pink),
            child: Padding(
              padding:const EdgeInsets.all(1.0),
              child:Text('Cerrado',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),))
          ,)
        ]
      );
    }
      else{
        b=buildTitle();
      }
      return b;



  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:CircleAvatar(backgroundImage: NetworkImage(this.user.getImagenPerfil())),
      title:title(context),//new Row(
    
      
      subtitle:lastConection(this.lastTimeDate),
      //contentPadding:this.padding,
      isThreeLine: true,
      enabled: true,
      trailing:CircleAvatar(backgroundImage: NetworkImage(this.product.getImagen())),
      dense:true,
    );
  }



}