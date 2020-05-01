import 'dart:core';
import 'dart:core';

import 'package:flutter_app2/pages/About2.dart';
import 'package:flutter_app2/pages/myOrders.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app2/pages/cart.dart';
import 'Favorites.dart';


class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}
final List product_list = new List();

class _ProductsState extends State<Products> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.green.shade400,
          centerTitle: true,
          title: Text('...التسوق من ', style: TextStyle(fontSize:25), ),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
//          new IconButton(icon: Icon(Icons.person, color: Colors.white), onPressed: (){
//            Navigator.push(context, MaterialPageRoute(builder: (context)=> new Drawer()));
//          }),
            new IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.white), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
            }),
          ],
        ),
        drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                //header
                new UserAccountsDrawerHeader(
                  accountName: Text('Customer Name'),
//                  accountEmail: Text(""),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Favorites()));
                  },
                  child: ListTile(
                    title: Text(
                        'المفضلة',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    leading: Icon(Icons.favorite,color: Colors.red.shade400,),
                  ),
                ),

                Divider(),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new myOrders()));
                  },
                  child: ListTile(
                    title: Text('طلباتي', style: TextStyle(fontSize: 20),),
                    leading: Icon(Icons.shopping_basket),
                  ),
                ),

                Divider(),

                InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('عنواني', style: TextStyle(fontSize: 20),),
                    leading: Icon(Icons.home),
                  ),
                ),
                Divider(),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  new About2()));
                  },
                  child: ListTile(
                    title: Text('عن التطبيق', style: TextStyle(fontSize: 20),),
                    leading: Icon(Icons.home),
                  ),
                ),
                Divider(),
              ],
            )
        ),

        body: StreamBuilder(

            stream: Firestore.instance
                .collection('vendors')
                .document(selectedShop)
                .snapshots(),
            builder: (context, snapshot) {
              print(selectedShop)  ;
              product_list.removeRange(0, product_list.length);
              if (snapshot.data['Products'].length == 0) {
                return Center(child: Text("No data in this shop"));
              }

              else {

                var newVendor = {
                  'name': snapshot.data['Credentials']['storeName'],
                  'phone':snapshot.data['phone'],

                };


                selectedShopInfo = newVendor;
                for (var i = 0; i < snapshot.data['Products'].length; i++) {

                  var product = {
                    'name' :snapshot.data['Products'][i]['name'],
                    'price':int.parse(snapshot.data['Products'][i]['price']),
                    'picture':snapshot.data['Products'][i]['image'],

                  };

                  var exist = false;

                  for (var j = 0; j < product_list.length; j++) {
                    if (product['picture'] ==
                        product_list[j]['picture']) {
                      exist = true;
                    }

                    if(exist == true && product['name'] != "name"){
                      product_list.removeAt(j);
                      exist = false;
                    }
                  }
                  if (exist == false) {
                    product_list.add(product);
                  }
                }

              }
              // return Text('done');
              return Listing();
            }
        ));
  }
}

class Listing extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index ){
          print('Products.dart index:  $index');
          print("product_list: ${product_list[index]}");

          return Similar_Single_prod(
            product_name:  product_list[index]['name'],
            product_picture: product_list[index]['picture'],
            product_price: product_list[index]['price'],
            product_index: index,
          );
        });}
}




class Similar_Single_prod extends StatelessWidget {

  String product_name;
  String product_picture;
  int product_price;
  var product_index;

  Similar_Single_prod({
    this.product_name,
    this.product_picture,
    this.product_price,
    this.product_index
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text("Hero 1"),
          child: Material(
            child: InkWell(
              //make the images functional , push adds  screen over screen
              onTap: (){
                indexChosenGlobal = product_index;
                print("Products.dart indexChosenGlobal123:   $indexChosenGlobal");
                Navigator.of(context).push(new MaterialPageRoute(
                  // passing information of the product to the product details page
                    builder: (context)=> new ProductDetails(
                      product_detail_name: product_name,
                      product_detail_picture: product_picture,
                      product_detail_price: product_price,
                      product_detail_index: indexChosenGlobal,
                    )));
              },
              child: GridTile(
                  footer: Container(
                      color: Colors.white,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              product_name, textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                          ),
                          new Text("\LBP $product_price",style: TextStyle(color: Colors.green.shade400,fontWeight: FontWeight.w800),),
                        ],
                      )
                  ),
                  child: Image.network(product_picture,
                    alignment: Alignment.center,width: 50,height: 50,
                  )),
            ),
          )),
    );
  }
}