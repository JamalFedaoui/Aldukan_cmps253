import 'package:flutter_app2/pages/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'package:flutter_app2/globals.dart';

import 'myOrders_products.dart';
import 'product_details.dart';
import 'product_details.dart';
import 'product_details.dart';
import 'product_details.dart';
import 'package:flutter_app2/pages/cart.dart';

final List<Map> myOrdersList = new List();


class myOrders extends StatefulWidget {
  @override
  _myOrdersState createState() => _myOrdersState();
}

class _myOrdersState extends State<myOrders> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: Text('الطلبات السابقة',
          style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal, fontSize: 20),),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Colors.white),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));

              }),

        ],
      ),

      //adding page cart_products
      body: new myOrders_products(),

    );
  }
}