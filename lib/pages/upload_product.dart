/*
 * FICHERO:     upload_product.dart
 * DESCRIPCIÓN: clases relativas a la pagina de subida de producto
 * CREACIÓN:    15/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/objects/product.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bookalo/widgets/upload_products/upload_images.dart';
import 'package:bookalo/widgets/upload_products/upload_title.dart';
import 'package:bookalo/widgets/upload_products/upload_tags.dart';
import 'package:bookalo/widgets/upload_products/upload_position.dart';
import 'package:flutter_tags/selectable_tags.dart';


/*
 *  CLASE:        UploadProduct
 *  DESCRIPCIÓN:  widget para la pagina de subida de un producto.
 * //TODO: add descripcion
 */
class UploadProduct extends StatefulWidget {

	UploadProduct({Key key}) : super(key: key);
	_UploadProduct createState() => _UploadProduct();
}

class _UploadProduct extends State<UploadProduct> {
	Product newP;
	List<bool> pagesValited = [true, false, true, true];
	var _pageOptions = [];
	List<Tag> kk = [];
	@override
	void initState(){
		super.initState();
		newP = new Product(0, '', 0, false, [], '', false,'', 0, 0, 0, []);
		newP.setState('Nuevo');
	//	newP.getTags().forEach((tag) => kk.add(Tag(title: tag)));
		_pageOptions = [
			UploadImages(),
			UploadTitle(
				formKey: _formKeys[1],
				prod: newP,
				valitedPage: (valited){setState(() {
				  pagesValited[1] = valited;
				});},
				isbnInserted: (isbn){
					setState(() { newP.setIsbn(isbn);});
				},
				tittleInserted: (tittle){
					setState(() { newP.setName(tittle);});
				},
				descriptionInserted: (desc){
					setState(() { newP.setDesciption(desc); });
				},
				stateProductInserted: (_state){
						setState(() {newP.setState(_state); });	
				},
			),
			UploadTags(
				initialT: newP.getTags(),
				onDeleteTag: (tag){
						setState(() { newP.deleteTag(tag); });
					},
				onInsertTag: (tag){
					setState(() {newP.insertTag(tag);});
					},
			),
			UploadPosition(),
		];
	}

	int currentPage = 0;
		//Contenido de cada página
	
	List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(),GlobalKey<FormState>(),];
	@override
	Widget build(BuildContext context) {
		double _height = MediaQuery.of(context).size.height;

		return DefaultTabController(
			length: 2,
			child: Scaffold(
					appBar: SimpleNavbar(preferredSize: Size.fromHeight(_height / 7.6)),
					body: _pageOptions[currentPage],	
					bottomNavigationBar:  CurvedNavigationBar(
						backgroundColor: Colors.white,
						color: Colors.pink,
						items: <Widget>[
							Icon(Icons.add, size: 30),
							Icon(Icons.list, size: 30),
							Icon(Icons.compare_arrows, size: 30),
							Icon(Icons.list, size: 30),
						],
						onTap: (index) {
								int i = 0;
						while(pagesValited[i] && i < index){
							i++;
						}
						
							setState(() {
								currentPage = i;
							});
						},
					),
				//	bottomNavigationBar: FancyBottomNavigation(
				//	tabs: [
				//			//TODO: Añadir a traslate. Modificar Iconos
				//			TabData(iconData: Icons.add_a_photo, title: 'Fotos'),
				//			TabData(iconData: Icons.search, title: 'Producto'),
				//			TabData(iconData: Icons.shopping_cart, title: 'Tags'),
				//			TabData(iconData: Icons.shopping_cart, title: 'Posición')
				//	],
				//	//Ejemplo para escuchar el cambio de estado
				//	
				//	onTabChangedListener: (position) {
			////			_formKeys[1].currentState.validate();
				//		int i = 0;
				//		while(pagesValited[i] && i < position){
				//			i++;
				//		}
				//		
				//			setState(() {
				//				currentPage = i;
				//			});
				//		},
				//),
		),
		);
	}

}