/*
 * FICHERO:     radial_button.dart
 * DESCRIPCIÓN: clases relativas al widget de botón radial animado
 * CREACIÓN:    19/03/2019
 */
import 'dart:math' as math;
import 'package:bookalo/objects/user.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/pages/report.dart';

/*
 *  CLASE:        RadialButton
 *  DESCRIPCIÓN:  widget para botón radial. Al ser pulsado, se expande y ofrece hasta
 *                tres opciones que se reparten en el espacio disponible y la opción
 *                de cerrarse de nuevo
 */
class RadialButton extends StatefulWidget {
  final String sellerId;
  final Product product;
  final User user;
  final Function() onFavorite;
  final bool wasMarkedAsFavorite;
  RadialButton(
      {Key key,
      this.product,
      this.sellerId,
      this.onFavorite,
      this.wasMarkedAsFavorite,
      this.user})
      : super(key: key);

  _RadialButtonState createState() => _RadialButtonState();
}

class _RadialButtonState extends State<RadialButton>
    with SingleTickerProviderStateMixin {
  bool isMarkedAsFavorite;
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  /*
   * Pre:   ---
   * Post:  comparte un perfil de usuario de prueba
   */
  void share() {
    Share.share(Translations.of(context)
            .text('share_product', params: [widget.product.getName()]) +
        'https://bookalo.es/api/generic_product_view/?id=' +
        widget.product.getId().toString());
    close();
  }

  void report() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Report(userToReport: widget.user)),
    );
  }

  void markAsFavorite() async {
    registerFavorite(widget.product);
    setState(() {
      widget.onFavorite();
      isMarkedAsFavorite = !isMarkedAsFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _colorAnimation = ColorTween(begin: Colors.pink, end: Colors.pink[700])
        .animate(_animationController);
    isMarkedAsFavorite = widget.wasMarkedAsFavorite;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double expandedSize = height / 4;
    double hiddenSize = height / 14;
    return SizedBox(
      height: expandedSize,
      width: expandedSize,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildExpandedBackground(expandedSize, hiddenSize),
              _buildFabCore(),
              _buildOption(
                  (isMarkedAsFavorite ? Icons.favorite : Icons.favorite_border),
                  math.pi,
                  markAsFavorite),
              _buildOption(Icons.share, -(math.pi / 2), share),
              _buildOption(Icons.flag, 0.0, report)
            ],
          );
        },
      ),
    );
  }

  /*
   * Pre:   expandedSize y hiddenSize son el tamaño final e inicial del botón
   *        en píxeles
   * Post:  ha devuelto el widget base del botón radial
   */
  Widget _buildExpandedBackground(double expandedSize, double hiddenSize) {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  /*
   * Pre:   icon es un icono, angle su posición relativa al botón en radianes
   *        y onClick la función e ejecutar al ser pulsado
   * Post:  ha devuelto un botón simple con las características especificadas
   */
  Widget _buildOption(IconData icon, double angle, VoidCallback onClick) {
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }

    return Transform.rotate(
      angle: angle,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: IconButton(
            onPressed: null,
            icon: Transform.rotate(
              angle: -angle,
              child: IconButton(
                icon: Icon(icon, size: iconSize),
                onPressed: onClick,
                color: Colors.white,
              ),
            ),
            iconSize: 26.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  /*
   * Pre:   ---
   * Post:  ha establecido la lógica de expansión del widget
   */
  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return FloatingActionButton(
      heroTag: "radialFAB",
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

  /*
   * Pre:   ---
   * Post:  ha expandido el botón radial
   */
  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  /*
   * Pre:   ---
   * Post:  ha cerrado el botón radial
   */
  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  /*
   * Pre:   ---
   * Post:  ha establecido la lógica de apertura del botón radial
   */
  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }
}
