//TODO:firebase user
//TODO: cambiar nombre fichero


class User{
  String nombre;
  String imagenPerfil;
  int reviews;
  double rating;

  User(this.nombre, this.imagenPerfil, this.reviews, this.rating);

  String getName(){return this.nombre;}
  String getImagenPerfil(){return this.imagenPerfil;}
  int getReviews(){return this.reviews;}
  double getRating(){return this.rating;}
}