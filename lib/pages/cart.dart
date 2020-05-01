import 'package:flutter_app2/pages/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'package:flutter_app2/globals.dart';

import 'product_details.dart';
import 'product_details.dart';
import 'product_details.dart';
import 'product_details.dart';

final List<Map> myOrdersList = new List();


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: Text('سلة التسوق',
          style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal, fontSize: 25),),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.delete,
                  color: Colors.white),
              onPressed: (){
//                for(var i=0; i< myCartList.length; i++){
                myCartList.removeRange(0, myCartList.length  );
                total =0;
                print("delete");
//                }

              }),

        ],
      ),

      //adding page cart_products
      body: new Cart_products(),

      bottomNavigationBar: new Container(
        color:  Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(

              title: new Text(":المجموع", style: TextStyle(fontSize: 15),),


              subtitle: new Text("\LBP $total",style: TextStyle(fontSize: 18,color: Colors.black),),
            ),),
            Expanded(

              child: new MaterialButton(onPressed: (){
                var newProduct= {
                  'name': myCartList[indexChosenGlobal]['name'],
                  'picture': myCartList[indexChosenGlobal]['picture'],
                  'price': myCartList[indexChosenGlobal]['price'],
                };
                var found = false;
                for(var i=0 ; i< myOrdersList.length ;i++ ) {
                  print(newProduct[i]);
                  if (newProduct['picture'] ==  myOrdersList[i]['picture']) {
                    found = true;
                    print("if statment ");
                  }
                }
                if (found == false){
                  myOrdersList.add(newProduct);
                  print(" found = f");
                }
              },
                child: new Text("الدفع",
                    style: TextStyle(color:Colors.white,fontSize: 18)),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}