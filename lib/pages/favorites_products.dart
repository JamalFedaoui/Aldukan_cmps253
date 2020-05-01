import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'package:flutter_app2/pages/storeScreen.dart';
import 'package:flutter_app2/pages/Products.dart';

import 'product_details.dart';
import 'product_details.dart';
import 'product_details.dart';

class favorite_products extends StatefulWidget {
  @override
  _favorite_productsState  createState() => _favorite_productsState();
}

class _favorite_productsState extends State<favorite_products> {

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: myFavoriteList.length,
        itemBuilder: (context,index){
          return Single_favorite_product(
            favorite_product_name: myFavoriteList[index]['name'],
            favorite_product_price: myFavoriteList[index]["price"],
            favorite_product_picture: myFavoriteList[index]["picture"],
          );
        });
  }
}
class Single_favorite_product extends StatelessWidget {
  final favorite_product_name;
  final favorite_product_picture;
  final favorite_product_price;

  Single_favorite_product({
    this. favorite_product_name,
    this. favorite_product_picture,
    this. favorite_product_price,

  });




  //constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        //adding the image
        leading: new Image.network( favorite_product_picture),
        title: new Text( favorite_product_name,
          style: TextStyle(fontSize: 20 , fontStyle: FontStyle.normal),),

        subtitle: new Column(
          children: <Widget>[
            //Row inside the column
            new Row(
              children: <Widget>[
                Container(

                  child: new IconButton(icon: Icon(Icons.add_circle , size: 45,color: Colors.green.shade400) ,
                    onPressed: (){
                      var newProduct= {
                        'name': product_list[indexChosenGlobal]['name'],
                        'picture': product_list[indexChosenGlobal]['picture'],
                        'price': product_list[indexChosenGlobal]['price'],
                      };
                      var found = false;
                      for(var i=0 ; i< myCartList.length ;i++ ) {
                        print(newProduct[i]);
                        if (newProduct['picture'] ==  myCartList[i]['picture']) {
                          found = true;
                          print("if statment ");
                        }
                      }
                      if (found == false){
                        myCartList.add(newProduct);
                        print(" found = f");
                      }

                    },

                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//
//                  child: new IconButton(icon: Icon(Icons.add , size: 17,color: Colors.green.shade400) , onPressed: (){}),
//                ),
              ],
            ),
            Container(
                alignment: Alignment.topRight,
                child: new Text("\LBP ${ favorite_product_price}",
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