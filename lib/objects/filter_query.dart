import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/translations.dart';

class FilterQuery extends Model {
  List _queryResult = List();
  Set<String> _tags = Set();
  double _maxDistance;
  double _maxPrice;
  double _minPrice;
  double _minRating;
  bool _isFiltering;

  FilterQuery() {
    _maxDistance = 10.0;
    _maxPrice = 80.0;
    _minPrice = 20.0;
    _minRating = 4;
    _isFiltering = false;
  }

  void removeFilter() {
    _isFiltering = false;
    _queryResult.clear();
    notifyListeners();
  }

  void addTag(String newTag) {
    this._tags.add(newTag);
    _isFiltering = true;
    _queryResult.clear();
    notifyListeners();
  }

  void removeTag(String tag) {
    this._tags.remove(tag);
    _queryResult.clear();
    notifyListeners();
  }

  void setMaxDistance(double maxDistance) {
    this._maxDistance = maxDistance;
    _isFiltering = true;
    _queryResult.clear();
    notifyListeners();
  }

  void setMaxPrice(double maxPrice) {
    this._maxPrice = maxPrice;
    _isFiltering = true;
    _queryResult.clear();
    notifyListeners();
  }

  void setMinPrice(double minPrice) {
    this._minPrice = minPrice;
    _isFiltering = true;
    _queryResult.clear();
    notifyListeners();
  }

  void setMinRating(double minRating) {
    this._minRating = minRating;
    _isFiltering = true;
    _queryResult.clear();
    notifyListeners();
  }

  String get tags => _isFiltering ? _tags.join(',') : "";
  List<String> get tagList => _tags.toList();
  double get maxDistance => _maxDistance;
  double get maxPrice => _maxPrice;
  double get minPrice => _minPrice;
  double get minRating => _minRating;
  bool get isFiltering =>
      _isFiltering &&
      !(_tags.length == 0 &&
          maxDistance == -1 &&
          maxPrice == -1 &&
          minPrice == -1 &&
          minRating == -1);
  List get queryResult => _queryResult;
  
  Widget _defineFilterTag(String title, Function onDeleted) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Chip(
        backgroundColor: Colors.pink,
        label: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        deleteIcon: Icon(Icons.remove_circle_outline, color: Colors.white),
        onDeleted: onDeleted,
      ),
    );
  }

  List<Widget> filterOptions(BuildContext context) {
    List<Widget> output = List();
    if (_maxDistance != -1) {
      output.add(_defineFilterTag(
          Translations.of(context).text("max_distance_tag") +
              " " +
              _maxDistance.toStringAsFixed(0) +
              "km", () {
        this.setMaxDistance(-1);
      }));
    }
    if (_maxPrice != -1) {
      output.add(_defineFilterTag(
          Translations.of(context).text("max_price_tag") +
              " " +
              _maxPrice.toStringAsFixed(0) +
              "€", () {
        this.setMaxPrice(-1);
      }));
    }
    if (_minPrice != -1) {
      output.add(_defineFilterTag(
          Translations.of(context).text("min_price_tag") +
              " " +
              _minPrice.toStringAsFixed(0) +
              "€", () {
        this.setMinPrice(-1);
      }));
    }
    if (_minRating != -1) {
      output.add(_defineFilterTag(
          Translations.of(context).text("min_rating_tag") +
              " " +
              _minRating.toStringAsFixed(0) +
              "/5", () {
        this.setMinRating(-1);
      }));
    }
    _tags.forEach((tag) {
      output.add(_defineFilterTag(tag, () {
        this.removeTag(tag);
      }));
    });
    return output;
  }
}
