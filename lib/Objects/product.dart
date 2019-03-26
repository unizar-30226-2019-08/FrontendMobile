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
  String _name;
  double _price;
  bool _sold;
  String _image; //url de la imagen

  Product(this._name, this._price, this._sold,
      this._image);

  String getName(){return this._name;}
  double getPrice(){return this._price;}
  bool getSold(){return this._sold;}
  String getImage(){return this._image;}

  String priceToString(){
    String r=(this._price).toStringAsFixed(1)+'€';
    return r;
  }
}