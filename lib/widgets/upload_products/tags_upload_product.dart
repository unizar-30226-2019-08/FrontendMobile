/*
 * FICHERO:     tag_upload_product.dart
 * DESCRIPCIÓN: clases relativas a la carga de tags proporcionados
 *              por backend para la subida de un nuevo producto
 * CREACIÓN:    07/05/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/upload_products/tag_selector_upload.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/http_utils.dart';

/*
 *  CLASE:        TagsUploadProduct
 *  DESCRIPCIÓN:  widget para la carga asíncrona de tags en el widget
 *                TagSelector
 */
class TagsUploadProduct extends StatefulWidget {
	final Function(String) onInsertTag;
  final Function(String) onDeleteTag;
	final List<String> initialTags;

	/*
	 * Pre:   initialTags es una lista de cero o más tags y onTagsChanged es una
	 *        función void
	 * Post:  ha generado el widget de tal forma que al modificarse la lista de tags
	 *        activos, ha ejecutado la callack onTagsChanged. Si initialTags era una
	 *        lista vacía, ha cargado tags iniciales de forma asíncrona de acuerdo a
	 *        la función _getTags(). En caso contrario, ha cargado los tags suministrados
	 */
	TagsUploadProduct({Key key, this.initialTags, this.onInsertTag,this.onDeleteTag}) : super(key: key);

	_TagsUploadProductState createState() => _TagsUploadProductState();
}

class _TagsUploadProductState extends State<TagsUploadProduct> {
    List<Tag> tagsParser = [];
    @override
    void initState(){
      super.initState();
      widget.initialTags.forEach((tag) => tagsParser.add(Tag(title: tag)));
    }

	@override
	Widget build(BuildContext context) {
		double height = MediaQuery.of(context).size.height;
		return FutureBuilder(
			future: parseTags(tagsParser),
			builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
				if (snapshot.hasData) {
					return TagsSelectorUplod(
            selectedTags: widget.initialTags,
						onInsertTag: (tag) {widget.onInsertTag(tag);},
						suggestedTags: snapshot.data,
						previousTagsLength: widget.initialTags.length,
            onDeleteTag: (tag){widget.onDeleteTag(tag);},
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