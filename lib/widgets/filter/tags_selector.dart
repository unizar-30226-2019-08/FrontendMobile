/*
 * FICHERO:     tag_selector.dart
 * DESCRIPCIÓN: clases relativas al widget de selección de tags para filtrado
 *              de artículos
 * CREACIÓN:    20/03/2019
 */
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        TagsSelector
 *  DESCRIPCIÓN:  widget para la selección de tags en el filtrado. Muestra inicialmente
 *                algunos y permite la adición de nuevos
 */
class TagsSelector extends StatefulWidget {
  final List<Tag> suggestedTags;
  final Function(Tag) onTagsChanged;

  /*
   * Pre:   suggestedTags es una lista de cero o más tags y onTagsChanged es una
   *        función void
   * Post:  ha generado el widget de tal forma que al modificarse la lista de tags
   *        activos, ha ejecutado la callack onTagsChanged
   */
  TagsSelector({Key key, this.onTagsChanged, this.suggestedTags})
      : super(key: key);

  _TagsSelectorState createState() => _TagsSelectorState();
}

class _TagsSelectorState extends State<TagsSelector> {
  GlobalKey<AutoCompleteTextFieldState<Tag>> key = new GlobalKey();
  List<Tag> selectedTags = [];

  @override
  void initState() {
    super.initState();
    selectedTags.addAll(widget.suggestedTags.sublist(0, 5));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: width / 3),
            width: width / 2,
            child: AutoCompleteTextField<Tag>(
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
                if (!selectedTags.contains(tag)) {
                  tag.active = true;
                  setState(() {
                    selectedTags.add(tag);
                  });
                  widget.onTagsChanged(tag);
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
            )),
        Container(
          margin: EdgeInsets.only(left: 20.0),
          child: SelectableTags(
            alignment: MainAxisAlignment.start,
            backgroundContainer: Theme.of(context).canvasColor,
            columns: 5,
            fontSize: 15.0,
            symmetry: false,
            tags: selectedTags,
            activeColor: Colors.pink,
            onPressed: (tag) {
              widget.onTagsChanged(tag);
            },
          ),
        ),
      ],
    );
  }
}
