import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/pages/Products.dart';
import 'package:flutter_app2/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final List<Map> myShopsList = new List();

class StoreScreen extends StatefulWidget {
  @override

  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade400,
          title: Center(
            child: Text(
              'اختر الدكان',
              style: TextStyle(color: Colors.white, fontSize: 35.0),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: StreamBuilder(
              stream: Firestore.instance.collection('vendors').snapshots(),
              builder: (context, snapshot) {
                myShopsList.removeRange(0, myShopsList.length);
                if (snapshot.hasData) {
                  for (var i = 0; i < snapshot.data.documents.length; i++) {
                    myVendors.add(snapshot.data.documents[i]['phone']);
                    if (snapshot.data.documents[i]['Credentials'] != null) {
                      var newShop = {
                        'name':snapshot.data.documents[i]['Credentials']['storeName'],
                        'phone': snapshot.data.documents[i]['phone'],
                        'image':snapshot.data.documents[i]['Credentials']['image']
                      };
                      var exist = false;

                      if (exist == false) {
                        myShopsList.add(newShop);
                      }
                    }
                  }
                }
                return NewProductList();
              }),
        ),
      ),
    );
  }
}
class NewProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(myShopsList.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 145.0,
                  child: FlatButton(
                    onPressed: () {
                      allProducts.removeRange(0, allProducts.length);
                      selectedShop = '';
                      selectedShop = myShopsList[index]['phone'].toString();
                      print(myShopsList[index]['phone']);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Products()),
                      );
                    },
                    child: Image.network(
                      myShopsList[index]['image'],
                      width: 200,
                      height: 200,),
                  )),
              Text("${myShopsList[index]['name']}",
                style: TextStyle(fontSize: 20),),
            ],
          );
        }),
      ),
    );
  }
}