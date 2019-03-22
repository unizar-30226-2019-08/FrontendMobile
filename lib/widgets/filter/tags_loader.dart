import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/filter/tags_selector.dart';

class TagsLoader extends StatefulWidget {
  final Function(Tag) onTagsChanged;
  final List<Tag> initialTags;

  TagsLoader({Key key, this.initialTags, this.onTagsChanged}) : super(key: key);

  _TagsLoaderState createState() => _TagsLoaderState();
}

class _TagsLoaderState extends State<TagsLoader> {
  
  Future<List<Tag>> _getTags() async{
    List<Tag> mockTagList = [];
    int tagCounter = 0;
    nouns.take(100).forEach((noun){
      mockTagList.add(
        Tag(
          id:tagCounter,
          title: noun,
          active: false
        )
      );
      tagCounter++;
    });
    return mockTagList;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.initialTags.length == 0){
      double height = MediaQuery.of(context).size.height;
      return FutureBuilder(
        future:_getTags(),
        builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot){
          if(snapshot.hasData){
            return TagsSelector(
              onTagsChanged: widget.onTagsChanged,
              suggestedTags: snapshot.data,
            );
          }else{
            return Container(
              height: height/4,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    }else{
      return TagsSelector(
        onTagsChanged: widget.onTagsChanged,
        suggestedTags: widget.initialTags,
      );
    }
  }
}