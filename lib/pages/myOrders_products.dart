import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'package:flutter_app2/pages/storeScreen.dart';


class myOrders_products extends StatefulWidget {
  @override
  _myOrders_productsState  createState() => _myOrders_productsState();
}

class _myOrders_productsState extends State<myOrders_products> {

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: myFavoriteList.length,
        itemBuilder: (context,index){
          return Single_myOrders_product(
            myOrders_product_name: myFavoriteList[index]['name'],
            myOrders_product_price: myFavoriteList[index]["price"],
            myOrders_product_picture: myFavoriteList[index]["picture"],
          );
        });
  }
}
class Single_myOrders_product extends StatelessWidget {
  final myOrders_product_name;
  final myOrders_product_picture;
  final myOrders_product_price;

  Single_myOrders_product({
    this. myOrders_product_name,
    this. myOrders_product_picture,
    this. myOrders_product_price,

  });




  //constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        //adding the image
        leading: new Image.network( myOrders_product_picture),
        title: new Text( myOrders_product_name,
          style: TextStyle(fontSize: 20 , fontStyle: FontStyle.normal),),

        subtitle: new Column(
          children: <Widget>[
            //Row inside the column
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Quantity: 1",style: TextStyle(

                    color: Colors.black,
                  ),),
                ),
              ],
            ),
            Container(
                alignment: Alignment.topRight,
                child: new Text("\LBP ${ myOrders_product_price}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:20,
                  ),)
            )
          ],
        ),
      ),
    );
  }
}