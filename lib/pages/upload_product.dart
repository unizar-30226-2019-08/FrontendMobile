/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/filter.dart';
import 'package:bookalo/objects/product.dart';
import 'package:flutter/services.dart';
import 'package:bookalo/widgets/filter/distance_map.dart';
import 'package:flutter_tags/selectable_tags.dart';

/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.//TODO: add descripcion
 */
class UploadProduct extends StatefulWidget {
  UploadProduct({Key key}) : super(key: key);

  _UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
  int _currentStep=0;
  Product newP;
  final List<Tag> _tags = [ //TODO: solo para pruebas
    Tag(
      id: 1,
      title: 'mates',
    ),
    Tag(
      id: 1,
      title: 'uni',
    ),
    Tag(
      id: 1,
      title: 'primero',
    ),
    Tag(
      id: 1,
      title: 'universidad',
    ),
    Tag(
      id: 1,
      title: 'universidad',
    )
  ];

@override
  Widget build(BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: SimpleNavbar(preferredSize: Size.fromHeight(_height / 7.6)),
          body: Stepper(
              steps: _mySteps(),
              currentStep: this._currentStep,
             onStepTapped: (step){
                setState(() {
                  this._currentStep = step;
                });
              }, //TODO: dejar navegar libremente entre pasos??
              onStepContinue: (){
                setState(() {
                  if(_currentStep < this._mySteps().length -1){
                    _currentStep=_currentStep+1;
                  }//TODO: else--> verificar si todo esta correcto
                  else{
                    print('Completado');
                  }
                });
              },
              onStepCancel: (){
                setState(() {
                  if(_currentStep > 0){
                    _currentStep = _currentStep - 1;
                  } else{
                    _currentStep = 0;
                  }
                });
              },
          )
      ),
    );
  }

  List<Step> _mySteps(){
    double _height = MediaQuery.of(context).size.height;
    List<Step> _steps =[
      Step(
        title: Text('¡Fotos, por favor!'),
        content: TextField(),
        isActive: _currentStep >= 0
      ),
      Step(
          title: Text('Título'),
          content: TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            onSaved: (String value) {
                newP.setName(value) ;
            },
            maxLines: 1,
            maxLength: 50,

          /*  validator: (value) {
              if (value.isEmpty || value.length < 1) {
                return 'Please enter name';
              }
            },*/ //TODO: hacer validacion
            decoration: new InputDecoration(
              labelText: 'Dale un nombre a tu producto',
              labelStyle:
              new TextStyle(decorationStyle: TextDecorationStyle.solid)
            ),

          ),
          isActive: _currentStep >= 1
      ),
      Step(
          title: Text('Descripción'),
          content: TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            onSaved: (String value) {
              newP.setDescription(value);
            },

            decoration: new InputDecoration(
                labelText: '¿Cómo es?',
                labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)
            ),
            maxLength: 700,
          ),
          isActive: _currentStep >= 2
      ),
      Step(
          title: Text('¿Unos tags?'), //TODO: ver logica para guardar tags
          content: Container(
            child: Column(
              children: <Widget>[
                SelectableTags(
                  height: _height / 25,
                  tags: _tags,
                  fontSize: 15.0,
                  onPressed: (tag) {},
                  margin: EdgeInsets.all(5.0),
                  activeColor: Colors.pink,
                  backgroundContainer: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                /*  onSaved: (String value) {
                    newP.description(value) ;
                  },*/  //TODO: ver como guardar tags

                  decoration: new InputDecoration(
                      hintText: 'tu propio tag',
                      icon: IconButton(icon: Icon(Icons.add_circle),
                        highlightColor: Colors.pink,
                        onPressed: () {},
                      ) , //TODO: boton para añadir tag
                      labelStyle:
                      new TextStyle(decorationStyle: TextDecorationStyle.solid)

                  ),
                  maxLines: 1,
                  maxLength: 50,
                ),
              ],
            ),
          ),
          isActive: _currentStep >= 3
      ),
      Step(
        title: Text('¿Dónde lo vendes?'),
        content: DistanceMap( //TODO: ver que pàrametros necesita
            height: _height / 5, distanceRadius:  1000),
        isActive: _currentStep >= 4
      )
    ];

    return _steps;
  }



Widget _imageViewer (){
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Image.network(
      'https://placeimg.com/640/480/any',
      fit: BoxFit.fill,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: EdgeInsets.all(10),
  );
}

  

}
