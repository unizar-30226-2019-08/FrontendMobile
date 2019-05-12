/*
 * FICHERO:     upload_title.dart
 * DESCRIPCIÓN: clases relativas a la nombre, descripcion y titulo de un usuario
 * CREACIÓN:    12/05/2019
 */

import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';
import 'package:flutter/material.dart';

/*
 *  CLASE:        UploadTitle
 *  TODO: Widget sin implementar
 *  DESCRIPCIÓN:  
 */

class UploadTitle extends StatefulWidget {
	final Function(String) isbnInserted;
	final Function(String) tittleInserted;
	final Function(String) descriptionInserted;
	final Function(String) stateProductInserted;
	final Function(bool) valitedPage;
	final formKey;
	final Product prod;
	const UploadTitle({Key key, this.isbnInserted, this.tittleInserted, this.descriptionInserted, this.prod, this.formKey, this.valitedPage, this.stateProductInserted}) : super(key: key);
	@override
	_UploadTitleState createState() => _UploadTitleState();
}

class _UploadTitleState extends State<UploadTitle> {
	String _value1="Nuevo";
	String _value2="Semi-Nuevo";
	String _value3="Viejo";
	String groupValue;
	bool titleIni = false, descIni = false; //Indica si se ha iniciado o no el titulo/descIni respectivamente
	bool validatePage = false, titleValited = false, isbnValited = false, descValited = false;
	void _valueChanged(String value) => setState(() => widget.prod.setState(value));
	@override
	void initState(){
		super.initState();
//			this._valueChanged(widget.prod.getState());
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
			child: Form(
						key: widget.formKey,
						onChanged: (){
							setState(() {
								validatePage = widget.formKey.currentState.validate() && titleIni && descIni;
								if(validatePage){
										 widget.formKey.currentState.save();
								}
							//	widget.stateProductInserted(groupValue);
								widget.valitedPage(validatePage);  
							});
								
								
							},
							
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
												//onPressed: barcodeScanning,
												onPressed: null,												
											),

							
						 TextFormField( //Input ISBN
											keyboardType: TextInputType.number,
											maxLines: 1,
											maxLength: 13, //13 numeros máximo
											maxLengthEnforced: true,
											initialValue: widget.prod.getISBN(),
											onSaved: (String isbnReaded) {
												widget.isbnInserted(isbnReaded);
											},
											decoration: InputDecoration(
													hintText:
															Translations.of(context).text("isbn_hint")),
											validator: (isbn) {
												if (isbn.isNotEmpty && isbn.length < 13) {
													//El ISBN ha de contener 13 dígitos
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
											initialValue: widget.prod.getName(),
											onSaved: (String value) {
												setState(() {
													widget.tittleInserted(value);
												});
													
											},
											decoration: InputDecoration(
												hintText:
															Translations.of(context).text("title_hint")),
												validator: (title) {
												if(title.length > 0){
													titleIni = true;
												}
												if (titleIni &&  title.length < 2) {
													//El nombre de articulo debe tener al menos 2 caracteres
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
													widget.descriptionInserted(value);
											},
											initialValue: widget.prod.getDescription(),
											decoration: InputDecoration(
													hintText:
															Translations.of(context).text("description_hint")),
											validator: (description) {
												if(description.length > 0){
													descIni = true;
												}
												if (descIni && description.length < 2) {
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
															onChanged: (_value1)=>changeState(_value1),
															activeColor: Colors.pink,
															groupValue:widget.prod.getState(),
													),


												new Text(Translations.of(context).text("Almost-New"),style:TextStyle(fontSize:10 )),
												new Radio(
															value: _value2,
															onChanged: (_value2)=> changeState(_value2),
															activeColor: Colors.pink,
															groupValue: widget.prod.getState(),
													),

												new Text(Translations.of(context).text("Old"),style:TextStyle(fontSize:10 )),
												new Radio(
															value: _value3,
															onChanged: (_value3)=>changeState(_value3),
															activeColor: Colors.pink,
															groupValue:widget.prod.getState(),
													),
												 ] ),
						 ] )

						),
		);
	}

	void changeState(String newState){
		widget.stateProductInserted(newState);
		_valueChanged(newState);
	}
}