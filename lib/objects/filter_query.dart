import 'package:json_annotation/json_annotation.dart';
import 'package:latlong/latlong.dart';

part 'filter_query.g.dart';

@JsonSerializable()

class FilterQuery{

  factory FilterQuery.fromJson(Map<String, dynamic> json) => _$FilterQueryFromJson(json);
  Map<String, dynamic> toJson() => _$FilterQueryToJson(this);

  Set<String> _tags = {};
  //LatLng _userLocation;
  double _maxDistance;
  double _maxPrice;
  double _minPrice;
  
  FilterQuery(){
    _maxDistance = 10.0;
    _maxPrice = 80.0;
    _minPrice = 10.0;
  }

  void setTags(Set<String> newTagSet){
    this._tags = newTagSet;
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

  double getMaxDistance(){
    return this._maxDistance;
  }
}