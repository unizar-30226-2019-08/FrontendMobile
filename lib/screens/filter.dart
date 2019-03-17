import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/filter/distance_map.dart';

class Filter extends StatefulWidget {

  Filter({Key key}) : super(key: key);

  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter>{
  double _maxDistance = 10.0;
  double _maxPrice = 80.0;
  double _minPrice = 20.0;
  AutoCompleteTextField<String> textField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String currentText = "";
  List<String> added = [];
  List<Tag> suggestionsTags = [];
  List<String> suggestions = [
    "Apple",
    "Armidillo",
    "Actual",
    "Actuary",
    "America",
    "Argentina",
    "Australia",
    "Antarctica",
    "Blueberry",
    "Cheese",
    "Danish",
    "Eclair",
    "Fudge",
    "Granola",
    "Hazelnut",
    "Ice Cream",
    "Jely",
    "Kiwi Fruit",
    "Lamb",
    "Macadamia",
    "Nachos",
    "Oatmeal",
    "Palm Oil",
    "Quail",
    "Rabbit",
    "Salad",
    "T-Bone Steak",
    "Urid Dal",
    "Vanilla",
    "Waffles",
    "Yam",
    "Zest"
  ];

  @override
  void initState(){
    super.initState();
    textField = AutoCompleteTextField<String>(
      decoration: InputDecoration(
        hintText: 'universidad',
        labelText: 'Busca algo'
      ),
      key: key,
      suggestions: suggestions,
      textChanged: (text) => currentText = text,
      itemBuilder: (context, suggestion){
        return Column(
          children: <Widget>[
            Divider(),
            Chip(
              label: Text(suggestion),
              labelStyle: TextStyle(color: Colors.white),
              backgroundColor: Colors.pink,
            ),
          ],
        );
      },
      itemSubmitted: (test) {
        setState(() {
          suggestionsTags.add(
            Tag(
              id: 100,
              title: test,
              active: true
            )
          );          
        });
      },
      itemFilter: (a, b){return true;},
      itemSorter: (a, b){return 1;}, 
    );
    int cnt = 0;
    suggestions.sublist(0,10).forEach((item){
        suggestionsTags.add (
            Tag (id: cnt,
                title: item,
                active: cnt%2 == 0,
            )
        );
        cnt++;
      });
  }

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Filtrado',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w300
          )),
        leading: Icon(Icons.sort),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: (){},
          )
        ],
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: width/3),
              width: width/2,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.pink),
                  onPressed: () {},
                ),
                title: textField,
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: SelectableTags(
                  alignment: MainAxisAlignment.start,
                  backgroundContainer: Theme.of(context).canvasColor,
                  columns: 5,
                  fontSize: 15.0,
                  symmetry: false,
                  tags: suggestionsTags,
                  activeColor: Colors.pink,
                  onPressed: (tag) {},

              ),
            ),            
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                Translations.of(context).text("max_distance"),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: width/1.5,
                  child: Slider(
                    min: 1.0,
                    max: 30.0,
                    value: _maxDistance,
                    onChanged: (newValue) {
                      setState(() => _maxDistance = newValue);
                    },              
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: width/4,
                  child: Text(
                    _maxDistance.toStringAsFixed(1) + ' km',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300
                    )
                  ),
                )
              ],
            ),
            DistanceMap(height: height/5, distanceRadius: _maxDistance*1000),            
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                Translations.of(context).text("price_range"),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300
                ),
              )
            ),            
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: width/7,
                    child: Text(
                      _minPrice.toStringAsFixed(0) + ' €',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300
                      )
                    ),
                  ),                
                  Container(
                    width: width/1.8,
                    child: new RangeSlider(
                      min: 1.0,
                      max: 100.0,
                      lowerValue: _minPrice,
                      upperValue: _maxPrice,
                      showValueIndicator: true,
                      valueIndicatorMaxDecimals: 1,
                      onChanged: (double newLowerValue, double newUpperValue) {
                        setState(() {
                          _minPrice = newLowerValue;
                          _maxPrice = newUpperValue;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: width/7,
                    child: Text(
                      _maxPrice.toStringAsFixed(0) + '€',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300
                      )
                    ),
                  )                
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  '434 productos disponibles',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}