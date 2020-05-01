import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/Favorites.dart';
import 'package:flutter_app2/pages/Horizontal_listview.dart';
import 'package:flutter_app2/pages/Products.dart';
import 'package:flutter_app2/pages/cart.dart';


class shoppingCart extends StatefulWidget {
  @override
  _shoppingCartState createState() => _shoppingCartState();
}

class _shoppingCartState extends State<shoppingCart> {
  @override
  Widget build(BuildContext context) {
//  Widget image_carousel = new Container(
//    height:200.0,
//    child: new Carousel(
//      boxFit: BoxFit.cover,
//      images: [
//        AssetImage('images/c1.jpg'),
//        AssetImage('images/c2.jpg'),
//        AssetImage('images/c3.jpg'),
//        AssetImage('images/c4.jpg'),
//        AssetImage('images/c5.jpg'),
//        AssetImage('images/c6.jpg'),
//        AssetImage('images/c7.jpg'),
//      ],
//      autoplay: false,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
//    ),
//  );
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text('Shopping from...'),
        actions: <Widget>[
//          new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
          new IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
          }),
          new IconButton(icon: Icon(Icons.favorite, color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> new Favorites()));
          })
        ],
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              //header
              new UserAccountsDrawerHeader(
                accountName: Text('Customer Name'),
                accountEmail: Text("76111222"),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(
                    color: Colors.green.shade400
                ),
              ),
              //body

              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, 'Favorites');
                },
                child: ListTile(
                  title: Text('/Favorites'),
                  leading: Icon(Icons.favorite,color: Colors.red.shade400,),
                ),
              ),

              Divider(),

              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/orders');
                },
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_basket),
                ),
              ),

              Divider(),

              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/customer_details');
                },
                child: ListTile(
                  title: Text('Details'),
                  leading: Icon(Icons.home),
                ),
              ),
              Divider(),

              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/About');
                },
                child: ListTile(
                  title: Text('About', ),
                  leading: Icon(Icons.home),
                ),
              ),
              Divider(),
            ],
          )
      ),

      body: Column(
        children: <Widget>[
          new Padding(padding: const EdgeInsets.all(10.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: new Text('Categories')
            ),
          ),

          HorizontalList(),

          new Padding(padding: const EdgeInsets.all(10.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: new Text('Items available')),),

          //grid view
          Flexible(
            child: Products(),
          ),
        ],
      ),
    );
  }
}