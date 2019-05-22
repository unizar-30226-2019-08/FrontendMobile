/*
 * FICHERO:     upload_tags.dart
 * DESCRIPCIÓN: clases relativas a los tags de un nuevo producto
 * CREACIÓN:    12/05/2019
 */

import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/upload_products/widgets_tags_uploader/tags_upload_product.dart';
import 'package:flutter/material.dart';

/*
 *  CLASE:        UploadTags
 *  DESCRIPCIÓN:  
 */

class UploadTags extends StatefulWidget {
  final Function(String) onInsertTag;
  final Function(String) descriptionInserted;
  final Function(bool) valitedPage;
  final Product prod;
  /*
   * Pre:   onInsertTag es una función void
   * Post:  Ha insertado un nuevo tag a Product
   */
  final Function(String) onDeleteTag;
  // final Function(bool) validate;
  final List<String> initialT;
  UploadTags(
      {Key key,
      this.onInsertTag,
      this.onDeleteTag,
      this.initialT,
      this.descriptionInserted,
      this.prod,
      this.valitedPage})
      : super(key: key);
  @override
  _UploadTagsState createState() => _UploadTagsState();
}

class _UploadTagsState extends State<UploadTags> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validatePage = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ListView(
        children: <Widget>[
          TagsUploadProduct(
            onInsertTag: (tag) {
              widget.onInsertTag(tag);
              //  widget.validate(widget.initialT.length > 0 && validatePage);
            },
            onDeleteTag: (tag) {
              widget.onDeleteTag(tag);
              // widget.validate(widget.initialT.length > 0 && validatePage);
            },
            initialTags: widget.initialT,
          ),
          Container(
            height: 15,
          ),
          Divider(),
          Form(
            autovalidate: true,
            key: formKey,
            onChanged: () {
              formKey.currentState.save();
              setState(() {
                validatePage = formKey.currentState.validate();
                widget.valitedPage(validatePage);
              });
            },
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              //maxLines: 4,
              maxLength: 1000, //1000 caracteres máximo
              maxLengthEnforced: true,
              onSaved: (String value) {
                widget.descriptionInserted(value);
              },
              initialValue: widget.prod.getDescription(),
              decoration: InputDecoration(
                  hintText: Translations.of(context).text("description_hint")),
              validator: (description) {
                if (description.length < 20) {
                  //El comentario debe tener al menos 30 caracteres
                  return Translations.of(context).text("description_too_short");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
