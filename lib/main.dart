import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/About.dart';
import 'package:flutter_app2/pages/Customer_details.dart';
import 'package:flutter_app2/pages/Favorites.dart';
import 'package:flutter_app2/pages/Orders.dart';
import 'package:flutter_app2/pages/home.dart';
import 'package:flutter_app2/pages/storeScreen.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/Dukan.dart';
import 'package:flutter_app2/pages/Phone.dart';
import 'package:flutter_app2/pages/items_picture_screen_vendor.dart';
import 'package:flutter_app2/pages/customer_selection.dart';
import 'package:flutter_app2/pages/Products.dart';
import 'package:flutter_app2/pages/product_details.dart';
import 'globals.dart' as globals;
import 'pages/Customer.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => loading(),
        '/phone': (context) => Phone(),
        '/home': (context) => Home(),
        '/customer': (context) => Customer(),
        '/dukan': (context) => Dukan(),
        '/StoreScreen': (context) => StoreScreen(),
        '/vendor_picture_screen': (context) => vendor_picture_screen(),
        '/customer_selection' : (context) => shoppingCart(),
        '/Products' : (context) => Products(),
        '/product_details' : (context) => ProductDetails(),
        '/orders' : (context) => Orders(),
        '/customer_details' : (context) => Customer_details(),
        '/Favorites' : (context) => Favorites(),
        '/About' : (context) => About(),
      },
    ));

// Since you don't have Products page, I'll write a piece of code to get data from firebase and to post the Products in it.
// To get data from firebase for example to get the vendor's credentials
// body: StreamBuilder(
//           stream: Firestore.instance
//               .collection('vendors')
//               .document(phoneNumber)     in the globals
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData)
//               return Center(child: Text('No data available'));
//             else {
//                 for (var i = 0; i < snapshot.data['Credentials'].length; i++) {
//                   var newUser = new User(                           User is a class you have to create as well as for the products
//                     snapshot.data['Credentials']['Fname'],

//                     snapshot.data['Credentials']['Lname'],
//                     snapshot.data['Credentials']['location'],
//                     snapshot.data['Credentials']['storeName'],
//                     snapshot.data['Credentials']['time'],
//                   );
//               }}})

// I implemented manually prodct list in the vendors collection ID:12312312 = phoneNumber
// body: StreamBuilder(
//           stream: Firestore.instance
//               .collection('vendors')
//               .document(phoneNumber)     in the globals   phone number which is equal to 12312312
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData)
//               return Center(child: Text('No data available'));
//             else {
//                 for (var i = 0; i < snapshot.data['Credentials'].length; i++) {
//                   var newProduct = new Product(
//                     snapshot.data['Products'][i]['name'],
//                     snapshot.data['Products'][i]['price'],
//                   );
//               }}})

// To add products in Firebase
// assume that you have a button 'add item' which adds the product to the products list and assume the phone number is 12312312

// when the button is pressed "onpressed"
// onpressed : (){
//   Firestore.instance.collection('Vendors').document(tempPhone).updateData({'Products':{'name' : _nameController.text , 'price' : _priceController.text} });
// }

//you have to create an array that stores all products found in firebase then append the new item then add it to the firebase
//assume your products array is myProducts = []
//use the stream builder: to get the data from DB and then create new products and add it to the myProducts list
//then append the new product.FirebaseApp

//then use this line of code:
// onpressed : (){
//Firestore.instance.collection('Vendors').document(tempPhone).updateData({'Products': myProducts});
// }
