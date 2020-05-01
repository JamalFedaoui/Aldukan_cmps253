import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location:'assets/c2.jpg',
            image_caption: 'Beverages',
          ),
          Category(
            image_location:'assets/c3.jpg',
            image_caption: 'Bakery & Breakfast',
          ),
          Category(
            image_location:'assets/c4.jpg',
            image_caption: 'Snacks',
          ),
          Category(
            image_location:'assets/c5.jpg',
            image_caption: 'Tobacco',
          ),
          Category(
            image_location:'assets/c6.jpg',
            image_caption: 'Beverages',
          ),
          Category(
            image_location:'assets/c7.jpg',
            image_caption: 'Beverages',
          ),

        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
      child:InkWell(onTap: (){},
        child: Container(
          width:90.0,
          height:80.0,
          child: ListTile(
            title: Image.asset(image_location),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child:Text(image_caption, style: new TextStyle(fontSize: 12.0,color: Colors.grey.shade700),),
            ),

          ),
        )
        ,),);
  }
}