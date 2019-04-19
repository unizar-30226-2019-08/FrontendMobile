/*
 * FICHERO:     list_viewer.dart
 * DESCRIPCIÓN: clase utilizada como constructor para el visor de listas
 * CREACIÓN:    15/04/2019
 */
import 'package:flutter/material.dart';

/*
    CLASE: KeepAliveFutureBuilder
    DESCRIPCIÓN: constructor que sustituye a "FUtureBuilder" nativo. Añade la
                funcionalidad "keepAlive". Esto significa que al constuir una
                lista no se destruyen los primeros elementos conforme se
                construyen los últimos.De esta forma se puede volver a consultar
                los primeros elementos de la lista sin volver a crearlos.
    USO: se utiliza igual que "FutureBuilder" y posee los mismos campos que este
 */

class KeepAliveFutureBuilder extends StatefulWidget {
  final Future future;
  final AsyncWidgetBuilder builder;

  KeepAliveFutureBuilder({this.future, this.builder});

  @override
  _KeepAliveFutureBuilderState createState() => _KeepAliveFutureBuilderState();
}

class _KeepAliveFutureBuilderState extends State<KeepAliveFutureBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: widget.builder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
