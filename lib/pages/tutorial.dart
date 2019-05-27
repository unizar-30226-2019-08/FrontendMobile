import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/widgets.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  List<Slide> slides = new List();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    //  slides.add(
    //    new Slide(
    //      title: "Bienvenido a Bookalo",
    //      description: "Durante este tutorial te enseñaremos los conceptos más básicos de la aplicación",
    //      backgroundColor: Color(0xfff5a623),
//
    //    ),
    //  );
    slides.add(
      new Slide(
        //title: "Busca productos que necesites",
        backgroundImage: "assets/images/tutorial_images/1-1.jpg",
        backgroundImageFit: BoxFit.fill,
      ),
    );
    slides.add(
      new Slide(
        //title: "Fltra por contenido",
        backgroundImage: "assets/images/tutorial_images/1-2-2.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );

    slides.add(
      new Slide(
     //   title: "Fltra por contenido",
        backgroundImage: "assets/images/tutorial_images/1-3.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/2-1.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/3-1.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/3-2.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/3-3.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );

    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/4-1.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/4-2.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/tutorial_images/4-3.jpg",
        backgroundImageFit: BoxFit.fill
      ),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffD02090),
      size: 66.0,
      
    );
  }
  Widget rednderDone() {
    return Icon(
      Icons.check_circle,
      color: Color(0xffD02090),
      size: 66.0,
      
    );
  }

  void onTabChangeCompleted(index) {
    /* Declarado únicamente para que funcione correctamente la progesion de los puntos */
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, '/buy_and_sell');
  }
  

  @override
  Widget build(BuildContext context) {
    print("Contruyend tutorial");
    return new IntroSlider(
      slides: this.slides,

      onDonePress: this.onDonePress,
      colorSkipBtn: Color(0xffD02090),
      widthSkipBtn: 66.0,
      onSkipPress: (){this.onDonePress();},
      renderDoneBtn: rednderDone(),
      renderNextBtn: renderNextBtn(),
      colorDot: Colors.pink[900],//Color(0x33ffcc5c),
      colorActiveDot: Colors.pink,//Color(0xffffcc5c),
      sizeDot: 8.0,
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
