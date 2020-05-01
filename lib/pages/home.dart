import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/Dukan.dart';
  import 'package:flutter_app2/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Customer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[800],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              height: 300,
              minWidth: 300,
              onPressed: () {
                Firestore.instance
                    .collection('vendors')
                    .document(phoneNumber)
                    .setData({'phone': phoneNumber});
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Dukan(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1.0, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(-1.0, 0),
                          ).animate(secondaryAnimation),
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              },
              child: Image.asset(
                'assets/new_vendor.jpg',
                height: 350,
                scale: 1.6,
              ),
            ),
            Column(
              children: <Widget>[
                MaterialButton(
                  height: 350,
                  minWidth: 450,
                  onPressed: () {
                    Firestore.instance
                        .collection('shoppers')
                        .document(phoneNumber)
                        .setData({'phone': phoneNumber});
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Customer(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset.zero,
                                end: const Offset(1.0, 0),
                              ).animate(secondaryAnimation),
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/vendor_phone.jpg',
                    height: 350,
                    width: 1000,
                    scale: 02,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
