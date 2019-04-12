//TODO:firebase user

class User {
  String _name;
  String _progileImage;

  User(this._name, this._progileImage);

  String getName() {
    return this._name;
  }

  String getImagenPerfil() {
    return this._progileImage;
  }
}