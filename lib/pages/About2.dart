import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/Favorites.dart';
import 'package:flutter_app2/pages/favorites_products.dart';
import 'package:flutter_app2/pages/cart.dart';

class About2 extends StatefulWidget {
  @override
  _About2State createState() => _About2State();
}

class _About2State extends State<About2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: Text('عن التطبيق ',
          style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal, fontSize: 20),),
        actions: <Widget>[

        ],
      ),

      //adding page cart_products
      body: Text("In February 2020, a group of 4 students at the American University of Beirut agreed to work on this project managed by Dr. Mahmoud Bdeir. This application is a grocery shopping app designed for non-tech friendly people. ", style: TextStyle(fontSize: 20,),



      ),
    );
  }
}