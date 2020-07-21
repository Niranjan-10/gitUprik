import 'package:flutter/material.dart';
import 'package:uprik/constant.dart';
import 'package:flare_flutter/flare_actor.dart';

class ServiceArea extends StatefulWidget {
  @override
  _ServiceAreaState createState() => _ServiceAreaState();
}

class _ServiceAreaState extends State<ServiceArea> {
  List _selecteCategorys = List();

  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "5", "category_name": "AC Repair"},
      {"category_id": "3", "category_name": "Carpanter"},
      {"category_id": "7", "category_name": "Electrician"},
      {"category_id": "8", "category_name": "Electrician"},
      {"category_id": "9", "category_name": "Electrician"},
      {"category_id": "10", "category_name": "Electrician"},
      {"category_id": "11", "category_name": "Electrician"},
      {"category_id": "11", "category_name": "Electrician"},
      {"category_id": "11", "category_name": "Electrician"},
      {"category_id": "11", "category_name": "Electrician"},
      {"category_id": "11", "category_name": "Electrician"},
      {"category_id": "11", "category_name": "Electrician"}
    ],
    "responseTotalResult":
        11 // Total result is 3 here becasue we have 3 categories in responseBody.
  };

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme, //from constantdart file
      title: 'Select Your Service Area',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Select Your Service Area',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Raleway", fontSize: 15.0),
          ),
        ),
        body: Container(
          child: Column(children: [
            checkBoxList(),
            MyFunction(
              function: helloWorld,
            )
          ]),
        ),
      ),
    );
  }

  Widget checkBoxList() {
    return Expanded(
      child: ListView.builder(
          itemCount: _categories['responseTotalResult'],
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
                value: _selecteCategorys.contains(
                    _categories['responseBody'][index]['category_id']),
                onChanged: (bool selected) {
                  _onCategorySelected(selected,
                      _categories['responseBody'][index]['category_id']);
                },
                title:
                    Text(_categories['responseBody'][index]['category_name']));
          }),
    );
  }

  void helloWorld() {
    print('hello world');
  }
}
