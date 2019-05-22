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
import 'package:barcode_scan/barcode_scan.dart';
import 'package:bookalo/widgets/list_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookalo/widgets/add_image.dart';
import 'package:bookalo/widgets/image_card.dart';
import 'dart:io';


/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.Consta de 4 pasos:
 *                Paso 1: Subida de imágenes
 *                Paso 2: Añadir descripción 
 *                Paso 3: Añadir tags
 *                Paso 4: Añadir localización geográfica
 */

class UploadProduct extends StatefulWidget {
  UploadProduct({Key key}) : super(key: key);
 
  _UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
  int _currentStep=0;
  String _isbn="";
  String _value1="Nuevo";
     String _value2="Semi-Nuevo";
      String _value3="Viejo";
   String groupValue;
  Product newP;
  void _valueChanged(String value) => setState(() => groupValue = value);
  List <File> _imageList=[];
  File image;
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








  Future barcodeScanning() async {
//imageSelectorGallery();

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._isbn = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._isbn = 'No camera permission!';
        });
      } else {
        setState(() => this._isbn = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this._isbn =
          'Nothing captured.');
    } catch (e) {
      setState(() => this._isbn = 'Unknown error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
   
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
    final _formKey = GlobalKey<FormState>();
    Image foto=Image.asset("assets/images/boli.png");
    File image=File("assets/images/boli.png");
    bool isSelected=false;
    List<Step> _steps =[


      //Image picker
      Step(
          title: Text(Translations.of(context)
                              .text("upload_description_title")),
          content:
            
            ListImageCard(),
           
          isActive: _currentStep >= 0
      ),





      Step(
          title: Text(Translations.of(context)
                              .text("upload_description_title")),
          content: Form(
             key: _formKey,
            child:Column(children: <Widget>[

              OutlineButton(
                        borderSide: BorderSide(color: Colors.pink, width: 3.0),
                        
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Text(
                          Translations.of(context).text("isbn_scan"),
                          style: TextStyle(
                              color: Colors.pink[600],
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: barcodeScanning,
                      ),

              
             TextFormField( //Input ISBN
                      keyboardType: TextInputType.number,
                      maxLines: 2,
                      maxLength: 13, //13 numeros máximo
                      maxLengthEnforced: false,
                      onSaved: (String isbnReaded) {
              // newP.isbn=isbnReaded;
                      },
                      decoration: InputDecoration(
                          hintText:
                              Translations.of(context).text("isbn_hint")),
                      validator: (isbn) {
                        if (isbn.length < 13) {
                          //El comentario debe tener al menos 30 caracteres
                          return Translations.of(context)
                              .text("isbn_too_short");
                        }
                      },
                    ),

               TextFormField( // Input titulo
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      maxLength: 50, //1000 caracteres máximo
                      maxLengthEnforced: true,
                      onSaved: (String value) {
               newP.name=value;
                      },
                      decoration: InputDecoration(
                          hintText:
                              Translations.of(context).text("title_hint")),
                      validator: (title) {
                        if (title.length < 2) {
                          //El comentario debe tener al menos 30 caracteres
                          return Translations.of(context)
                              .text("title_too_short");
                        }
                      },
                    ),


                TextFormField(//Input Descripcion
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      maxLength: 50, //1000 caracteres máximo
                      maxLengthEnforced: true,
                      onSaved: (String value) {
               newP.description=value;
                      },
                      decoration: InputDecoration(
                          hintText:
                              Translations.of(context).text("description_hint")),
                      validator: (description) {
                        if (description.length < 2) {
                          //El comentario debe tener al menos 30 caracteres
                          return Translations.of(context)
                              .text("description_too_short");
                        }
                      },
                    ),


                new Row(
                        children:[
                             new Text(Translations.of(context).text("New"),style:TextStyle(fontSize:10 )),
                          new Radio(
                  value: _value1,
                  onChanged: (_value1)=>this._valueChanged(_value1),
                  activeColor: Colors.pink,
                  groupValue:groupValue,
                          ),


                  new Text(Translations.of(context).text("Almost-New"),style:TextStyle(fontSize:10 )),
                          new Radio(
                  value: _value2,
                  onChanged: (_value2)=>this._valueChanged(_value2),
                  activeColor: Colors.pink,
                  groupValue:groupValue,
                          ),

                  new Text(Translations.of(context).text("Old"),style:TextStyle(fontSize:10 )),
                          new Radio(
                  value: _value3,
                  onChanged: (_value3)=>this._valueChanged(_value3),
                  activeColor: Colors.pink,
                  groupValue:groupValue,
                          ),


                
                         ] ),





             ] )

            ),
         isActive: _currentStep >= 1  
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
          isActive: _currentStep >= 2
      ),
      Step(
          title: Text('¿Dónde lo vendes?'),
          content: DistanceMap( //TODO: ver que pàrametros necesita
              height: _height / 5, distanceRadius:  1000),
          isActive: _currentStep >= 3
      )
    ];

    return _steps;
  }

   
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



