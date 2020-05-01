
/**
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/Products.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {

  var store_list = [
    {
      "name": "Abu Naji",
      "picture": "assets/example1.jpg",
      "location": "Hamra",
    },
    {
      "name": "Abu Ali",
      "picture": "assets/example2.jpg",
      "location": "Verdun",
    },
    {
      "name": "24/7",
      "picture": "assets/example3.jpg",
      "location": "Hamra",
    }
  ];
    @override
    Widget build(BuildContext context) {
      return GridView.builder(
          itemCount: store_list.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Single_prod(
              store_name: store_list[index]['name'],
              store_name: store_list[index]['picture'],
              store_location: store_list[index]['location'],
            );
          });
    }

    class Single_Store extends StatelessWidget {

    final store_name;
    final store_name;
    final store_location;

    Single_Store({
    this.store_name,
    this.store_picture,
    this.store_location,
    });
    @override
    Widget build(BuildContext context) {
    return Container();
    }
    }
    **/