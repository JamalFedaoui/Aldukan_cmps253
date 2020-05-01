import 'dart:io';
import 'package:flutter_app2/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


var urlPic = "";
class Dukan extends StatefulWidget {
  @override
  _DukanState createState() => _DukanState();
}

class _DukanState extends State<Dukan> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController storeName = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController time = new TextEditingController();



  void save() {

    var data = {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'storeName': storeName.text,
      'location': location.text,
      'time': time.text,
      'image': 'blah'
    };
    print(data);
  }

  File _image;


  Future<void> showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap:() {
                  openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8),),
              GestureDetector(
                child: Text("Camera"),
                onTap:() {
                  opencamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    this.setState(() {
      _image = picture;
    });
    String myNewfileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${phoneNumber}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    setState(() {
      urlPic = url;
    });

    Navigator.of(context).pop();
  }

  void opencamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      _image = picture;
    });

    String myNewfileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${phoneNumber}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    setState(() {
      urlPic = url;
    });
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: Text('سجل'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: TextField(
                      controller: firstName,
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
                    controller: lastName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'الاسم الأخير:  ',
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
                    controller: storeName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'اسم الدكانة: ',
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
                    controller: location,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'موقع المتجر:  ',
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
              /**
                  Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: TextField(
                  controller: time,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ساعات العمل:  ',
                  labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  ),
                  fillColor: Colors.green[800],
                  filled: true,
                  ),
                  ),
                  ),
                  ),
               */
              Container(
                child:
                _image == null ? Text(
                    "لم يتم تحديد صورة",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )  : Image.file(_image),
              ),
              FlatButton(
                child: Text(
                  "حدد صورة (اختياري)",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  showChoiceDialog(context);
                },
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: FlatButton(
                      color: Colors.green.shade400,
                      onPressed: () {
                        print('urlPic : $urlPic');
                        var myfinalPic;
                        if(urlPic == ""){
                          myfinalPic = "https://media.istockphoto.com/vectors/mini-market-building-outdoors-with-trees-sky-and-cloud-vector-id1153139957?k=6&m=1153139957&s=612x612&w=0&h=nPH4A5RHWTeTrO4P5fVRcIxGXxUN5gKAmleBLrnZ2Js=";
                        }
                        else{
                          myfinalPic = urlPic;
                        }
                        Firestore.instance
                            .collection('vendors')
                            .document(phoneNumber)
                            .updateData({
                          'Credentials': {
                            'Fname': firstName.text,
                            'Lname': lastName.text,
                            'storeName': storeName.text,
                            'location': location.text,
                            'time': time.text,
                            'image': myfinalPic
                          }
                        });
                        Firestore.instance
                            .collection('vendors')
                            .document(phoneNumber)
                            .updateData({'Products': []});

                        save();
                        Navigator.pushNamed(context, '/vendor_picture_screen');
                      },
                      child: Text("سجل",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          )),
                    )),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

/*
import 'dart:io';
import 'package:flutter_app2/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


var urlPic = "";
class Dukan extends StatefulWidget {
  @override
  _DukanState createState() => _DukanState();
}

class _DukanState extends State<Dukan> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController storeName = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController time = new TextEditingController();



  void save() {
    
    var data = {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'storeName': storeName.text,
      'location': location.text,
      'time': time.text,
      'image': 'blah'
    };
    print(data);
  }

  File _image;


  Future<void> showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap:() {
                  openGallery(context);
              },
              ),
              Padding(padding: EdgeInsets.all(8),),
              GestureDetector(
                child: Text("Camera"),
                onTap:() {
                  opencamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    this.setState(() {
      _image = picture;
    });
    String myNewfileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${phoneNumber}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    setState(() {
      urlPic = url;
    });
    
    Navigator.of(context).pop();
  }

  void opencamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 20);
    this.setState(() {
      _image = picture;
    });
    
    String myNewfileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${phoneNumber}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    setState(() {
      urlPic = url;
    });
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        centerTitle: true,
        title: Text('سجل'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'الاسم الاول: ',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        fillColor: Colors.green[800],
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
                    controller: lastName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'الاسم الأخير:  ',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      fillColor: Colors.green[800],
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
                    controller: storeName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'اسم الدكانة: ',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      fillColor: Colors.green[800],
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
                    controller: location,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'موقع المتجر:  ',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      fillColor: Colors.green[800],
                      filled: true,
                    ),
                  ),
                ),
              ),
              /**
                  Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: TextField(
                  controller: time,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ساعات العمل:  ',
                  labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  ),
                  fillColor: Colors.green[800],
                  filled: true,
                  ),
                  ),
                  ),
                  ),
               */
              Container(
                child:
                _image == null ? Text("Still waiting") : Image.file(_image),
              ),
              FlatButton(
                child: Text(
                  "Select image (Optional)",
                ),
                onPressed: () {
                  showChoiceDialog(context);
                },
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: FlatButton(
                      color: Colors.green[800],
                        onPressed: () {
                          print('urlPic : $urlPic');
                          var myfinalPic;
                          if(urlPic == ""){
                            myfinalPic = "https://media.istockphoto.com/vectors/mini-market-building-outdoors-with-trees-sky-and-cloud-vector-id1153139957?k=6&m=1153139957&s=612x612&w=0&h=nPH4A5RHWTeTrO4P5fVRcIxGXxUN5gKAmleBLrnZ2Js=";
                          }
                          else{
                            myfinalPic = urlPic;
                          }
                          Firestore.instance
                              .collection('vendors')
                              .document(phoneNumber)
                              .updateData({
                            'Credentials': {
                              'Fname': firstName.text,
                              'Lname': lastName.text,
                              'storeName': storeName.text,
                              'location': location.text,
                              'time': time.text,
                              'image': myfinalPic
                            }
                          });
                          Firestore.instance
                              .collection('vendors')
                              .document(phoneNumber)
                              .updateData({'Products': []});

                          save();
                          Navigator.pushNamed(context, '/vendor_picture_screen');
                        },
                      child: Text("سجل",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          )),
                    )),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
*/