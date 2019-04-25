/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';


/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.//TODO: add descripcion
 */
class UploadProduct extends StatefulWidget {
  UploadProduct({Key key}) : super(key: key);

  _UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: SimpleNavbar(preferredSize: Size.fromHeight(height / 7.6)),
          body: Stepper(
            steps: _mySteps(),
            currentStep: this._currentStep,
            onStepTapped: (step) {
              setState(() {
                this._currentStep = step;
              });
            },
            onStepContinue: () {
              setState(() {
                if (_currentStep < this._mySteps().length - 1) {
                  _currentStep = _currentStep + 1;
                } //TODO: else--> verificar si todo esta correcto
                else {
                  print('Completado');
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep = _currentStep - 1;
                } else {
                  _currentStep = 0;
                }
              });
            },
          )),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
          title: Text('Step 1'),
          content: TextField(),
          isActive: _currentStep >= 0),
      Step(
          title: Text('Step 2'),
          content: TextField(),
          isActive: _currentStep >= 1),
      Step(
          title: Text('Step 3'),
          content: TextField(),
          isActive: _currentStep >= 2)
    ];

    return _steps;
  }

  Widget _imageViewer() {
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
