import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app2/pages/storeScreen.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final TextEditingController _firstNameController =
  new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _bldgNameController = new TextEditingController();
  final TextEditingController _floorController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: Text('سجل'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'الاسم الاول: ',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'اسم الشهرة:  ',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: TextField(
                  controller: _bldgNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ' المبنى: ',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: TextField(
                  controller: _floorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'الطابق:',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: FlatButton(
                child: Text(
                  "تم",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                color: Colors.green.shade400,
                onPressed: () {
                  Firestore.instance
                      .collection('shoppers')
                      .document(phoneNumber)
                      .updateData({
                    'Credentials': {
                      'Fname': _firstNameController.text,
                      'Lname': _lastNameController.text,
                      'Building': _bldgNameController.text,
                      'Floor': _floorController.text
                    }
                  });
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          StoreScreen(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}