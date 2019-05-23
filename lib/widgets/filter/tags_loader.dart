/*
 * FICHERO:     tag_loader.dart
 * DESCRIPCIÓN: clases relativas a la carga de tags desde el backend en el
 *              widget de selección de tags
 * CREACIÓN:    20/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/filter/tags_selector.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/http_utils.dart';

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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: parseTags(widget.initialTags, seeErrorWith: context),
      builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
        if (snapshot.hasData) {
          return TagsSelector(
            onTagsChanged: widget.onTagsChanged,
            suggestedTags: snapshot.data,
            previousTagsLength: widget.initialTags.length,
          );
        } else {
          return Container(
            height: height / 4,
            child: Center(child: BookaloProgressIndicator()),
          );
        }
      },
    );
  }
}
