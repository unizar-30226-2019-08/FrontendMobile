/*
 * FICHERO:     bookalo_progress.dart
 * DESCRIPCIÓN: indicador de carga con logo de Bookalo
 * CREACIÓN:    29/03/2019
 */
import 'dart:math' as math;
import 'package:flutter/material.dart';

/*
 *  CLASE:        BookaloProgressIndicator
 *  DESCRIPCIÓN:  widget para indicador de carga con el logo de Bookalo
 */
class BookaloProgressIndicator extends StatefulWidget {
  final Color color;

  /*
   * Pre:   color, opcionalmente, debe contener el color deseado
   *        del indicador de carga. En caso de no especificarse ninguno.
   *        será Colors.pink
   * Post:  ha construido el widget
   */ 
  BookaloProgressIndicator({Key key, this.color = Colors.pink}) : super(key: key);

  _BookaloProgressIndicatorState createState() => _BookaloProgressIndicatorState();
}

class _BookaloProgressIndicatorState extends State<BookaloProgressIndicator> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _rotator;

  void initState(){ 
    super.initState();
    _controller =  AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );    
    _rotator = Tween(begin: math.pi*2, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease
      ),
    )..addListener((){
      setState(() {});
    });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context){
    return Transform.rotate(
      angle: _rotator.value,
      child: IconButton(
        onPressed: () {},
        iconSize: 50.0,
        icon: ImageIcon(
          AssetImage('assets/images/mini_bookalo.png'),
          color: widget.color,
        ),
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}