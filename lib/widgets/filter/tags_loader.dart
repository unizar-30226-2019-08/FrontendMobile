/*
 * FICHERO:     tag_loader.dart
 * DESCRIPCIÓN: clases relativas a la carga de tags desde el backend en el
 *              widget de selección de tags
 * CREACIÓN:    20/03/2019
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/filter/tags_selector.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

/*
 *  CLASE:        TagsLoader
 *  DESCRIPCIÓN:  widget para la carga asíncrona de tags en el widget
 *                TagSelector
 */
class TagsLoader extends StatefulWidget {
  final Function(Tag) onTagsChanged;
  final List<Tag> initialTags;

  /*
   * Pre:   initialTags es una lista de cero o más tags y onTagsChanged es una
   *        función void
   * Post:  ha generado el widget de tal forma que al modificarse la lista de tags
   *        activos, ha ejecutado la callack onTagsChanged. Si initialTags era una
   *        lista vacía, ha cargado tags iniciales de forma asíncrona de acuerdo a
   *        la función _getTags(). En caso contrario, ha cargado los tags suministrados
   */
  TagsLoader({Key key, this.initialTags, this.onTagsChanged}) : super(key: key);

  _TagsLoaderState createState() => _TagsLoaderState();
}

class _TagsLoaderState extends State<TagsLoader> {
  /*
   * Pre:   ---
   * Post   devolverá una lista de tags. Por el momento, mockup
   */
  Future<List<Tag>> _getTags() async {
    List<Tag> mockTagList = [];
    int tagCounter = 0;
    nouns.take(100).forEach((noun) {
      mockTagList.add(Tag(id: tagCounter, title: noun, active: false));
      tagCounter++;
    });
    return mockTagList;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialTags.length == 0) {
      double height = MediaQuery.of(context).size.height;
      return FutureBuilder(
        future: _getTags(),
        builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
          if (snapshot.hasData) {
            return TagsSelector(
              onTagsChanged: widget.onTagsChanged,
              suggestedTags: snapshot.data,
            );
          } else {
            return Container(
              height: height / 4,
              child: Center(child: BookaloProgressIndicator()),
            );
          }
        },
      );
    } else {
      return TagsSelector(
        onTagsChanged: widget.onTagsChanged,
        suggestedTags: widget.initialTags,
      );
    }
  }
}
