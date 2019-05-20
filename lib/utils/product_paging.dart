import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/filter_query.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

typedef ItemWidgetBuilder<T> = Widget Function(int index, T item);

class ProductPagination<T> extends StatefulWidget {
  ProductPagination({
    Key key,
    @required this.pageBuilder,
    @required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.progress,
    this.onError,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.padding,
    this.itemExtent,
    this.cacheExtent,
    this.semanticChildCount,
  })  : assert(pageBuilder != null),
        assert(itemBuilder != null),
        super(key: key);

  final PaginationBuilder<T> pageBuilder;
  final ItemWidgetBuilder<T> itemBuilder;

  final Axis scrollDirection;

  final Widget progress;

  final Function(dynamic error) onError;

  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap = false;
  final EdgeInsetsGeometry padding;
  final double itemExtent;
  final bool addAutomaticKeepAlives = true;
  final bool addRepaintBoundaries = true;
  final bool addSemanticIndexes = true;
  final double cacheExtent;
  final int semanticChildCount;

  @override
  _ProductPaginationState<T> createState() => _ProductPaginationState<T>();
}

class _ProductPaginationState<T> extends State<ProductPagination<T>> {
  bool _isLoading = false;
  bool _isEndOfList = false;

  void fetchMore(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      widget
          .pageBuilder(ScopedModel.of<FilterQuery>(context).queryResult.length)
          .then((list) {
        _isLoading = false;
        if (list.isEmpty) {
          _isEndOfList = true;
        }
        setState(() {
          ScopedModel.of<FilterQuery>(context).queryResult.addAll(list);
        });
      }).catchError((error) {
        setState(() {
          _isEndOfList = true;
        });
        print(error);
        if (widget.onError != null) {
          widget.onError(error);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMore(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      controller: widget.controller,
      physics: widget.physics,
      primary: widget.primary,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      itemExtent: widget.itemExtent,
      cacheExtent: widget.cacheExtent,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      scrollDirection: widget.scrollDirection,
      itemBuilder: (context, position) {
        if (position <
            ScopedModel.of<FilterQuery>(context).queryResult.length) {
          return widget.itemBuilder(position,
              ScopedModel.of<FilterQuery>(context).queryResult[position]);
        } else if (position ==
                ScopedModel.of<FilterQuery>(context).queryResult.length &&
            !_isEndOfList) {
          fetchMore(context);
          return widget.progress ?? defaultLoading();
        }
        return null;
      },
    );
  }

  Widget defaultLoading() {
    return Align(
      child: SizedBox(
        height: 40,
        width: 40,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
