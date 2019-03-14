import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class MiniChat extends StatelessWidget {
  final String imagenUsuario; //imagen del usuario
  final String imagenProd;    //imagen del producto
  final String usuario;
  final String ultimoMens;
  final bool compra;          //vale true si quiere comprar y false si quiere vender
  final bool cerrado;         //vale true si la transaciión está cerrada
  final int fechaUltiCon;     //indica la fecha de la última conexión
  final EdgeInsetsGeometry padding;
 // final Color color;
  MiniChat({Key key,this.imagenUsuario,this.imagenProd,
  this.usuario,this.ultimoMens,this.compra,this.cerrado,
  this.fechaUltiCon,this.padding}): super(key: key);

  Text ultimaCon(var ultimaConexion){
    String aMostrar='';
    var fechaActual=new DateTime.now();
    var diferencia=fechaActual.difference(ultimaConexion);
      int horas=ultimaConexion.hour();
      int minutos=ultimaConexion.min();
      int dia=ultimaConexion.day();
      int mes=ultimaConexion.month();
    if(diferencia.inDays==1){
      aMostrar='Ayer '+ horas.toString()+':'+minutos.toString();
    }
    else if(diferencia.inDays==0){
      aMostrar='Hoy '+ horas.toString()+':'+minutos.toString();
    }
    else if(diferencia.inDays>1){
      aMostrar=dia.toString() + 'de' +mes.toString() + ' ' + horas.toString()+':'+minutos.toString();
    }
    return Text(aMostrar);
  }

  Text construirTitulo(){
    String aMostrar=this.usuario+':'+this.ultimoMens;
    return Text(aMostrar);
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:CircleAvatar(backgroundImage: NetworkImage(this.imagenUsuario)),
      title:construirTitulo(),
      subtitle: ultimaCon(this.fechaUltiCon),
      contentPadding:this.padding,
      isThreeLine: true,
      enabled: true,
      trailing:CircleAvatar(backgroundImage: NetworkImage(this.imagenProd)),
      dense:true,
    );
  }



}