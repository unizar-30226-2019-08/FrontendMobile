import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class ChipDist extends StatelessWidget {
  final int distancia;
  final EdgeInsetsGeometry padding;
  final Color color;
  final TextStyle fuente;
  final EdgeInsetsGeometry labelPadding;
  ChipDist({Key key,
    this.distancia,this.padding,this.color,this.fuente,this.labelPadding}): super(key: key);

  Text distanciaReal(int distancia){
    String aMostrar;
    int metros=distancia;
    double km=0;
    while(metros>1000){
      metros=metros-1000;
      km=km+1;
    }
    km=km+(metros*(0.001));
    //if(metros>0){
     // aMostrar=km.toString() + 'km' + metros.toString() +' ' +'m';
     aMostrar=km.toStringAsFixed(1)+' '+'km';
   // }
    //else{
    //    aMostrar=km.toString() + 'km';
    //}
    return Text(aMostrar);
  }
  @override
  Widget build(BuildContext context) {
    return Chip(
      label:distanciaReal(this.distancia),
      backgroundColor:this.color,
      padding:this.padding,
      labelPadding: this.labelPadding,
      labelStyle: this.fuente,
    );
  }
}