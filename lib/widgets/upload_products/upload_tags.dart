/*
 * FICHERO:     upload_tags.dart
 * DESCRIPCIÓN: clases relativas a los tags de un nuevo producto
 * CREACIÓN:    12/05/2019
 */


import 'package:bookalo/widgets/upload_products/tags_upload_product.dart';
import 'package:flutter/material.dart';

/*
 *  CLASE:        UploadTags
 *  TODO: Widget sin implementar
 *  DESCRIPCIÓN:  
 */

class UploadTags extends StatefulWidget {
  final Function(String) onInsertTag;
  /*
   * Pre:   onInsertTag es una función void
   * Post:  Ha insertado un nuevo tag a Product
   */
  final Function(String) onDeleteTag;
  final Function(bool) validate;
  final List<String> initialT;
  UploadTags({Key key, this.onInsertTag, this.onDeleteTag, this.initialT, this.validate}) : super(key: key);
  @override
  _UploadTagsState createState() => _UploadTagsState();

}

class _UploadTagsState extends State<UploadTags> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
      children: <Widget>[
          TagsUploadProduct(
            onInsertTag: (tag) {widget.onInsertTag(tag); widget.validate(widget.initialT.length >0 );},
            onDeleteTag: (tag) {widget.onDeleteTag(tag); widget.validate(widget.initialT.length >0 );},
            initialTags: widget.initialT,
            
          ),
        ],
      )
    );
  }
  
}
