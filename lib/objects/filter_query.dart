import 'package:latlong/latlong.dart';

class FilterQuery{
  Set<String> _tags = {};
  LatLng _userLocation;
  double _maxDistance = 10.0;
  double _maxPrice = 80.0;
  double _minPrice = 80.0;

  void addTag(String newTag){
    _tags.add(newTag);
  }

  void removeTag(String tag){
    _tags.remove(tag);
  }

  void setMaxDistance(double maxDistance){
    this._maxDistance = maxDistance;
  }

  void setMaxPrice(double maxPrice){
    this._maxPrice =maxPrice;
  }

  void setMinPrice(double minPrice){
    this._minPrice = minPrice;
  }
}