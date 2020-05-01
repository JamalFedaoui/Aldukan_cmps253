import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/pages/Products.dart';
import 'package:flutter_app2/pages/storeScreen.dart';
import 'package:flutter_app2/globals.dart';


final List<Map> myCartList = new List(); //to add cart items
final List<Map> myFavoriteList = new List();
class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;
  int product_detail_index;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_price,
    this.product_detail_picture,
    this.product_detail_index
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green.shade400,
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ), onPressed: () {

            print('products_details.dart indexChosenGlobal123: $indexChosenGlobal');
            print("product_list $product_list");
            var newProduct= {
              'name': product_list[indexChosenGlobal]['name'],
              'picture': product_list[indexChosenGlobal]['picture'],
              'price': product_list[indexChosenGlobal]['price'],
            };
            var found = false;
            for(var i=0 ; i< myFavoriteList.length ;i++ ) {
              print(newProduct[i]);
              if (newProduct['picture'] ==  myFavoriteList[i]['picture']) {
                found = true;
                print("if statment ");
              }
            }
            if (found == false){
              myFavoriteList.add(newProduct);
              print(" found = f");
            }

          })
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 250.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                //have to give reference to picture in parent class to we can access it by using widget
                child: Image.network(widget.product_detail_picture,),
              ),
            ),
          ),

          Divider(color: Colors.white10),

          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child : new Text("${widget.product_detail_name}",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black,
                            backgroundColor: Colors.white10),
                        textAlign: TextAlign.center,),
                    )
                  ],
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child : new Text("LBP ${widget.product_detail_price}",
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15,color: Colors.redAccent.shade200,backgroundColor: Colors.white10),
                        textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.white10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("منتجات ذات صله", style: TextStyle( fontSize: 17),),
          ),

          // ===== Similar products section =====
          Container(
            height: 200.0,
            child: Similar_products(),
          ),



          // ======= add to cart Button =======
          Row(
            children: <Widget>[

              new Row(
                children: <Widget>[
                  new IconButton(icon: Icon(Icons.remove , size: 17,), onPressed: (){}),
                  new Text(" 1 ",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
                  new IconButton(icon: Icon(Icons.add, size: 17), onPressed: () {}),
                ],
              ),

              // ###############  ON PRESSED BUTTON FOR ADD TO CART ###########################

              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    print('products_details.dart indexChosenGlobal123: $indexChosenGlobal');
                    print("product_list $product_list");
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
//                        total= total + int.parse(newProduct['price']);
                      print(" found = f");
                      for(var i=0; i< myCartList.length; i++) {
//                      total+= myCartList[i]['price'];
                        total = total + myCartList[i]['price'];

                      }
                    }
//                    for(var i=0; i< myCartList.length; i++) {
////                      total+= myCartList[i]['price'];
//                      total = total + myCartList[i]['price'];
//
//                    }
//                      if(found== true){
////                        quantity++;
//                      print(" found = true");
//                      }

                    print('newProduct: $newProduct');
//                    myCartList.add(newProduct);
                    print('myCartList123: $myCartList');
                  },
                  color: Colors.green.shade400,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text("أضف إلى السلة",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal
                    ),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index ){
          print('index: $index');

          return Similar_single_prod(
            product_name:  product_list[index]['name'],
            product_picture: product_list[index]['picture'],
            product_price: product_list[index]['price'],
            product_index: index,
          );
        });

  }
}

class Similar_single_prod extends StatelessWidget {
  final product_name;
  final product_picture;
  final product_price;
  final product_index;

  Similar_single_prod({
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
                Navigator.of(context).push(new MaterialPageRoute(
                  // passing information of the product to the product details page
                    builder: (context)=> new ProductDetails(
                        product_detail_name: product_name,
                        product_detail_picture: product_picture,
                        product_detail_price: product_price,
                        product_detail_index: product_index
                    )

                ));

              } ,
              child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              product_name,
                              style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
                            ),
                          ),
                          new Text("\LBP $product_price",style: TextStyle(color: Colors.green.shade200,fontWeight: FontWeight.w800),),
                        ],)
                  ),
                  child: Image.network(product_picture,
                    alignment: Alignment.center, scale: 4,
                  )),
            ),

          )),
    );
  }
}