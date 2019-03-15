
/*
  Clase provisional para producto. Usada para realizar las pruebas de
  los widgets de visualizaciond e productos (miniaturas y producto general)

 */

class Product{
  String nombre;
  double precio;
  bool vendido;
  String imagen;//almacena el directorio de la imagen, solo para puebas

  Product(this.nombre, this.precio, this.vendido,
      this.imagen);

  String getNombre(){return this.nombre;}
  double getPrecio(){return this.precio;}
  bool getVendido(){return this.vendido;}
  String getImagen(){return this.imagen;}
}