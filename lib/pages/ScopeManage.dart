//import 'dart:io';
//
//
//import 'dart:io';
//
//import 'package:path/path.dart';
//
//import 'package:path_provider/path_provider.dart';
//
//// Cart Listing
//
//
//// Add Cart
//void addCart(Data dd) {
//  print(dd);
//  print(_cart);
//  int _index = _cart.indexWhere((d) => d.shop_id == dd.id);
//  if (_index > -1) {
//    success = false;
//    cartMsg = "${dd.name.toUpperCase()} already added in Cart list.";
//  } else {
//    this.InsertInCart(dd);
//    success = true;
//    cartMsg = "${dd.name.toUpperCase()} successfully added in cart list.";
//  }
//}
//
//class Data {
//  String name;
//  int id;
//  String image;
//  double rating;
//  double price;
//  bool fav;
//  int shop_id;
//}
