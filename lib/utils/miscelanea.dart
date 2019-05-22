/*
 *  FICHERO:      miscelanea.dart
 *  DESCRIPCIÓN:  funciones varias
 */

String parseISBN(String _isbn) {
  if (_isbn.length == 13) {
    return _isbn.substring(0, 3) +
        '-' +
        _isbn.substring(3, 6) +
        '-' +
        _isbn.substring(6, 11) +
        '-' +
        _isbn[11] +
        '-' +
        _isbn[12];
  }
}
