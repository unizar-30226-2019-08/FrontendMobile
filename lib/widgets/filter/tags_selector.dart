import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/translations.dart';

class TagsSelector extends StatefulWidget {
  final List<Tag> suggestedTags; 
  final Function(Tag) onTagsChanged;

  TagsSelector({Key key, this.onTagsChanged, this.suggestedTags}) : super(key: key);

  _TagsSelectorState createState() => _TagsSelectorState();
}

class _TagsSelectorState extends State<TagsSelector> {

  GlobalKey<AutoCompleteTextFieldState<Tag>> key = new GlobalKey();
  List<Tag> selectedTags = [];


  @override
  void initState() { 
    super.initState();
    selectedTags.addAll(widget.suggestedTags.sublist(0,5));  
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: width/3),
          width: width / 2,
          child: AutoCompleteTextField<Tag>(
            decoration: InputDecoration(
              hintText: Translations.of(context).text("tag_example"),
              labelText: Translations.of(context).text("add_tags")
            ),
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
            itemSubmitted: (tag){
              if(!selectedTags.contains(tag)){
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
               return suggestions.title.toLowerCase().contains(input.toLowerCase());
            },
          )
        ),
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
