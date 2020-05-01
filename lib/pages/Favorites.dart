import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/Favorites.dart';
import 'package:flutter_app2/pages/favorites_products.dart';
import 'package:flutter_app2/pages/cart.dart';
class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: Text('المفضلة',
          style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal, fontSize: 20),),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Colors.white),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
            },

          ),
        ],
      ),

      //adding page cart_products
      body: new favorite_products(),



    );
  }
}