/*
 * FICHERO:     product.dart
 * DESCRIPCIÓN: clase Procduct
 * CREACIÓN:    15/03/2019
 */



/*
  CLASE: Product
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un producto
                de la aplicacion
 */
class Product{
  //Usuario--> firebase
  String _name;
  double _price;
  //List<String> tags;
  bool _sold;
  List<String> _images; //url de las imagenes
  String _state; //TODO: declarar tipo enumerado??
  double _lat;
  double _long;
  String _send; //TODO: declarar tipo enumerado??
  String _descripcion;
  int _likes;


  Product(this._name, this._price, this._sold,
      this._images);

  String getName(){return this._name;}
  double getPrice(){return this._price;}
  bool getSold(){return this._sold;}
  String getPrimaryImage(){return this._images.elementAt(0);}

  String priceToString(){
    String r=(this._price).toStringAsFixed(1)+'€';
    return r;
  }
}