import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:bookalo/translations.dart';

class RadialButton extends StatefulWidget {

  RadialButton();

  _RadialButtonState createState() => _RadialButtonState();
  
}

class _RadialButtonState extends State<RadialButton> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  void share(){
    Share.share(
      Translations.of(context).text('share_profile', param1: 'Juan') + 'https://bookalo.es/user=123'
    );
    close();
  }

  @override
  void initState(){
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[700]).animate(_animationController);
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    double expandedSize = height/4;
    double hiddenSize = height/14;
    return SizedBox(
      height: expandedSize,
      width: expandedSize,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child){
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildExpandedBackground(expandedSize, hiddenSize),
              _buildFabCore(),
              _buildOption(Icons.chat_bubble_outline, 0.0, share),
              _buildOption(Icons.favorite, math.pi, share),
              _buildOption(Icons.share, -(math.pi/2), share)
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpandedBackground(double expandedSize, double hiddenSize){
    double size = hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildOption(IconData icon, double angle, VoidCallback onClick){
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: null,
            icon: new Transform.rotate(
              angle: -angle,
              child: IconButton(
                icon: Icon(icon, size: iconSize),
                onPressed: onClick, 
                color: Colors.white,
              ),
            ),
            iconSize: 26.0,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildFabCore(){
    double scaleFactor = 2*(_animationController.value -0.5).abs();
    return FloatingActionButton(
      onPressed: _onFabTap,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(1.0, scaleFactor),
        child: Icon(
          _animationController.value > 0.5 ? Icons.close : Icons.more_horiz,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  open() {
    if (_animationController.isDismissed){
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted){
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed){
      open();
    } else {
      close();
    }
  }
}
