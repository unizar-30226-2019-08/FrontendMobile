import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:latlong/latlong.dart';
import 'package:bookalo/translations.dart';

class FilterQuery extends Model {
  List _queryResult = List();
  Set<String> _tags = Set();
  double _latitude;
  double _longitude;
  bool _usesDistance;
  double _maxDistance;
  bool _usesMinPrice;
  double _maxPrice;
  bool _usesMaxPrice;
  double _minPrice;
  bool _usesRating;
  int _minRating;
  bool _endReached;

  FilterQuery() {
    _latitude = 0.0;
    _longitude = 0.0;
    _maxDistance = 15.0;
    _maxPrice = 75.0;
    _minPrice = 2.0;
    _minRating = 0;
    _endReached = false;
    _usesDistance = false;
    _usesMaxPrice = false;
    _usesMinPrice = false;
    _usesRating = false;
  }

  void handleQueryChange() {
    _queryResult.clear();
    _endReached = false;
    notifyListeners();
  }

  void removeFilter() {
    _usesDistance = false;
    _usesMinPrice = false;
    _usesMaxPrice = false;
    _usesRating = false;
    _tags.clear();
    handleQueryChange();
  }

  void addTag(String newTag) {
    _tags.add(newTag);
    handleQueryChange();
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    handleQueryChange();
  }

  void setMaxDistance(double maxDistance) {
    _maxDistance = maxDistance;
    _usesDistance = true;
    handleQueryChange();
  }

  void setMaxPrice(double maxPrice) {
    _maxPrice = maxPrice;
    _usesMaxPrice = true;
    handleQueryChange();
  }

  void setMinPrice(double minPrice) {
    _minPrice = minPrice;
    _usesMinPrice = true;
    handleQueryChange();
  }

  void setMinRating(int minRating) {
    _minRating = minRating;
    _usesRating = true;
    handleQueryChange();
  }

  void updatePosition(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    //TODO: handleQueryChange();
  }

  void setEndReached(bool value) {
    _endReached = value;
  }

  String get tags => isFiltering ? _tags.join(',') : "";
  List<String> get tagList => _tags.toList();
  LatLng get position => LatLng(_latitude, _longitude);
  bool get usesDistance => _usesDistance;
  bool get usesMinPrice => _usesMinPrice;
  bool get usesMaxPrice => _usesMaxPrice;
  bool get usesRating => _usesRating;
  double get maxDistance => _maxDistance;
  double get maxPrice => _maxPrice;
  double get minPrice => _minPrice;
  int get minRating => _minRating;
  bool get isFiltering =>
      _tags.length != 0 ||
      _usesDistance ||
      _usesMinPrice ||
      _usesMaxPrice ||
      _usesRating;
  List get queryResult => _queryResult;
  bool get endReached => _endReached;

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
    if (_usesDistance) {
      output.add(_defineFilterTag(
          Translations.of(context).text("max_distance_tag") +
              " " +
              _maxDistance.toStringAsFixed(0) +
              "km", () {
        _usesDistance = false;
        notifyListeners();
      }));
    }
    if (_usesMaxPrice) {
      output.add(_defineFilterTag(
          Translations.of(context).text("max_price_tag") +
              " " +
              _maxPrice.toStringAsFixed(0) +
              "€", () {
        _usesMaxPrice = false;
        notifyListeners();
      }));
    }
    if (_usesMinPrice) {
      output.add(_defineFilterTag(
          Translations.of(context).text("min_price_tag") +
              " " +
              _minPrice.toStringAsFixed(0) +
              "€", () {
        _usesMinPrice = false;
        notifyListeners();
      }));
    }
    if (_usesRating) {
      output.add(_defineFilterTag(
          Translations.of(context).text("min_rating_tag") +
              " " +
              _minRating.toStringAsFixed(0) +
              "/5", () {
        _usesRating = false;
        notifyListeners();
      }));
    }
    _tags.forEach((tag) {
      output.add(_defineFilterTag(tag, () {
        removeTag(tag);
        notifyListeners();
      }));
    });
    return output;
  }
}
