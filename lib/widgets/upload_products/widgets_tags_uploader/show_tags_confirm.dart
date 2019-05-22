import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';

class ShowTagsConfirm extends StatefulWidget {
  final List<String> tags;

  const ShowTagsConfirm({Key key, this.tags}) : super(key: key);
  @override
  _ShowTagsConfirmState createState() => _ShowTagsConfirmState();
}

class _ShowTagsConfirmState extends State<ShowTagsConfirm> {
  List<Tag> showTags = [];

  @override
  void initState() {
    super.initState();
    widget.tags.forEach((tag) {
      showTags.add(Tag(title: tag, active: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      child: SelectableTags(
        alignment: MainAxisAlignment.start,
        backgroundContainer: Theme.of(context).canvasColor,
        columns: 5,
        fontSize: 15.0,
        symmetry: false,
        tags: showTags,
        activeColor: Colors.pink,
        onPressed: (tag) {},
      ),
    );
  }
}
