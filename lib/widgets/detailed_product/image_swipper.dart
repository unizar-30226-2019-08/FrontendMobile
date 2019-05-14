/*
 * FICHERO:     image_swiper.dart
 * DESCRIPCIÓN: relativo al widget ImageSwiper
 * CREACIÓN:    25/04/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/detailed_product/full_screen_images.dart';

/*
 *  CLASE:        ImageSwiper
 *  DESCRIPCIÓN:  widget para mostrar imágenes deslizables
 */
class ImageSwiper extends StatefulWidget {
  final Product product;
  final bool expandible;

  /*
   * Pre:   producto es un Product con imágenes y expandible indica si es el
   *        widget deberá expandirse a pantalla completa al ser tocado
   * Post:  ha construido el widget
   */
  ImageSwiper({Key key, this.product, this.expandible}) : super(key: key);

  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          widget.product.getImages()[index],
          fit: BoxFit.fill,
        );
      },
      itemCount: widget.product.getImages().length,
      pagination: new SwiperPagination(
        alignment: Alignment(0, -0.9),
      ),
      control: new SwiperControl(),
      onTap: (position) {
        if (widget.expandible) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                        product: widget.product,
                      )));
        }
      },
    );
  }
}
