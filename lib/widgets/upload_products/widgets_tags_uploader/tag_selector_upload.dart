/*
 * FICHERO:     tag_selector_upload.dart
 * DESCRIPCIÓN: clases relativas al widget de selección de tags para filtrado
 *              de artículos
 * CREACIÓN:    09/05/2019
 */
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:bookalo/translations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/*
 *  CLASE:        TagsSelectorUplod
 *  DESCRIPCIÓN:  widget para la selección de tags en el filtrado. Muestra inicialmente
 *                algunos y permite la adición de nuevos
 */
class TagsSelectorUplod extends StatefulWidget {
  List<Tag> suggestedTags = [];
  final List<String> selectedTags;
  final int previousTagsLength;
  final Function(String) onDeleteTag;
  final Function(String) onInsertTag;
  final Function(bool) validatedPage;

  /*
	 * Pre:   suggestedTags es una lista de cero o más tags y onTagsChanged es una
	 *        función void
	 * Post:  ha generado el widget de tal forma que al modificarse la lista de tags
	 *        activos, ha ejecutado la callack onTagsChanged
	 */
  TagsSelectorUplod(
      {Key key,
      this.onDeleteTag,
      this.onInsertTag,
      this.suggestedTags,
      this.previousTagsLength,
      this.selectedTags,
      this.validatedPage})
      : super(key: key);

  _TagsSelectorUplodState createState() => _TagsSelectorUplodState();
}

class _TagsSelectorUplodState extends State<TagsSelectorUplod> {
  GlobalKey<AutoCompleteTextFieldState<Tag>> key = GlobalKey();
  List<String> selectedTagsIn = [];
  bool showError = false;
  String msgError = "";
//	List<Tag> inputTags = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _column = 3;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: width / 3),
            width: width / 2,
            child: AutoCompleteTextField<Tag>(
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                  hintText: Translations.of(context).text("tag_example"),
                  labelText: Translations.of(context).text("add_tags")),
              key: key,
              suggestions: widget.suggestedTags,
              itemBuilder: (context, suggestion) {
                return Column(
                  children: <Widget>[
                    Divider(),
                    Chip(
                      label: Text(suggestion.title),
                      labelStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.pink,
                    ),
                  ],
                );
              },
              submitOnSuggestionTap: true,
              itemSubmitted: (tag) {
                if (!widget.selectedTags.contains(tag.title)) {
                  tag.active = true;
                  setState(() {
                    widget.onInsertTag(tag.title);
                    showError = false;
                  });
                }
              },
              itemSorter: (a, b) {
                return 1;
              },
              itemFilter: (suggestions, input) {
                return suggestions.title
                    .toLowerCase()
                    .contains(input.toLowerCase());
              },
              textSubmitted: (inputetx) {
                const maxLong = 50;
                if (inputetx.length > 0 && inputetx.length < maxLong) {
                  setState(() {
                    widget.onInsertTag(inputetx);
                    showError = false;
                  });
                } else {
                  if (inputetx.length >= maxLong)
                    setState(() {
                      msgError = Translations.of(context).text(
                          "error_tag_tamanyo",
                          params: [maxLong.toString()]);
                      showError = true;
                    });
                }
              },
            )),
        ((showError)
            ? Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  msgError,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.redAccent),
                ))
            : Container()),
        Container(
          child: InputTags(
            iconColor: Colors.black,
            tags: widget.selectedTags,
            columns: _column,
            fontSize: 14,
            symmetry: true,
            iconBackground: Colors.white,
            color: Colors.pink,
            lowerCase: true,
            textFieldHidden: true,
            alignment: MainAxisAlignment.center,
            backgroundContainer: Theme.of(context).canvasColor,
            autofocus: false,
            onDelete: (tag) {
              setState(() {
                widget.onDeleteTag(tag);
              });
            },
          ),
        ),
        (widget.selectedTags.isEmpty)
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  Translations.of(context).text("no_tags"),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 26),
                ),
              )
            : Container(),
        (widget.selectedTags.isEmpty)
            ? Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: Icon(MdiIcons.tagPlus,
                          color: Colors.pink, size: 40.0)),
                  Expanded(
                      child: Text(
                          Translations.of(context).text("motivation_tags")))
                ],
              )
            : Container(),
      ],
    );
  }
}
