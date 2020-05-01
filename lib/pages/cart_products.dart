import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'package:flutter_app2/pages/storeScreen.dart';



class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: myCartList.length,
        itemBuilder: (context,index){
          return Single_cart_product(
            cart_product_name: myCartList[index]['name'],
            cart_product_price: myCartList[index]["price"],
            cart_product_picture: myCartList[index]["picture"],
          );
        });
  }
}
class Single_cart_product extends StatelessWidget {
  final cart_product_name;
  final cart_product_picture;
  final cart_product_price;




  //constructor
  Single_cart_product({
    this.cart_product_name,
    this.cart_product_picture,
    this.cart_product_price,


  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        //adding the image
        leading: new Image.network(cart_product_picture),
        title: new Text(cart_product_name,
          style: TextStyle(fontSize: 20 , fontStyle: FontStyle.normal),),

        subtitle: new Column(
          children: <Widget>[
            //Row inside the column
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Quantity:",style: TextStyle(

                    color: Colors.black,
                  ),),
                ),
              ],
            ),
            Container(
                alignment: Alignment.topRight,
                child: new Text("\LBP ${cart_product_price}",
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