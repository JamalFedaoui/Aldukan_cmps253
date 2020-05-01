import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter_app2/globals.dart';


final List<Map> myProducts = List();


class vendor_picture_screen extends StatefulWidget {
  @override
  _vendor_picture_screenState createState() => _vendor_picture_screenState();
}

class _vendor_picture_screenState extends State<vendor_picture_screen> {

  TextEditingController product_name = new TextEditingController();
  TextEditingController product_price = new TextEditingController();

  File _image;


  Future<void> deleteornot(BuildContext context,  index){
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Are you sure you want to delete?"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Yes"),
                onTap: () {
                  myProducts.removeAt(index);
                  (context as Element).reassemble();
                },
              ),
              Padding(padding: EdgeInsets.all(8),),
              GestureDetector(
                child: Text("No"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
            "تفاصيل المنتج",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: product_name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'اسم المنتج: ',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    fillColor: Colors.green[400],
                    filled: true,
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  controller: product_price,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'سعر المنتج: : ',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      fillColor: Colors.green[400],
                      filled: true,
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  child: Text(
                      "Make a choice",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: GestureDetector(
                  child: Text("Gallery"),
                  onTap:() {
                    openGallery(context);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(8),),
              GestureDetector(
                child: Text("Camera"),
                onTap:() {
                  opencamera(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
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
    var my_product = {
      'image': url,
      'name': product_name.text,
      'price': product_price.text,
      'delete':false
    };
    print(my_product);
    myProducts.add(my_product);
    print("before Firestore");
    Firestore.instance
        .collection('vendors')
        .document(phoneNumber)
        .updateData({'Products': myProducts});
    print("before After");
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
    var my_product = {
      'image': url,
      'name': product_name.text,
      'price':product_price.text,
      'delete':false
    };
    print(my_product);
    myProducts.add(my_product);
    print("before Firestore");
    Firestore.instance
        .collection('vendors')
        .document(phoneNumber)
        .updateData({'Products': myProducts});
    print("before After");
    }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      _image = image;
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

    var my_product = {
      'image': url,
      'name': "product x",
      'price':'0000',
      'delete':false
    };
    print(my_product);
    myProducts.add(my_product);
    print("before Firestore");
    Firestore.instance
        .collection('vendors')
        .document(phoneNumber)
        .updateData({'Products': myProducts});
    print("before After");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        centerTitle: true,
        title: Text(
            'اعرض أغراضك',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance
                    .collection('vendors')
                    .document(phoneNumber)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text('No data in DB '));
                  else {
                    if (snapshot.data['Products'].length == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: Text(
                                "لا يوجد لديك منتجات",
                                style: TextStyle(fontSize: 25.0),
                              )),
                        ],
                      );
                    } else {
                      for (var i = 0; i < snapshot.data['Products'].length; i++) {
                        var newProduct = {
                          'image':snapshot.data['Products'][i]['image'],
                          'name':snapshot.data['Products'][i]['name'],
                          'price':snapshot.data['Products'][i]['price'],
                          'delete':snapshot.data['Products'][i]['delete']
                        };
                        print(newProduct['image']);
                        var exist = false;
                        for (var j = 0; j < myProducts.length; j++) {
                          if (newProduct['image'] ==
                              myProducts[j]['image'].toString()) {
                            exist = true;
                          }
                        }
                        if (exist == false && newProduct['delete'] == false) {
                          myProducts.add(newProduct);
                        }
                        print(myProducts);
                      }
                    }
                  }
                  return Listing();
                }),
          ],
        ),
      ),
      // Center(

      //   // child: _image == null
      //   //     ? Text('No image selected.')
      //   //     : Image.file(_image),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[400],
        onPressed:() {
          showChoiceDialog(context);
        } ,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }


// /**

//   List<Asset> images = List<Asset>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children:List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return Column(children:<Widget>[
//           FlatButton(onPressed: null,
//           child: AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         ),)

//         ]);

//       }),
//     );
//   }

//   Future<void> loadAssets() async {
//     List<Asset> resultList = List<Asset>();

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarTitle: "اختر الصور",
//           allViewTitle: "جميع الصور",
//         ),
//       );
//     } on Exception catch (e) {
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       images = resultList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('الأغراض'),
//           centerTitle: true,
//           backgroundColor: Colors.green[800],
//         ),
//         body: Column(
//           children: <Widget>[
//             RaisedButton(
//               child: Text("اختر الصور"),
//               onPressed: loadAssets,
//             ),
//             Expanded(
//               child: buildGridView(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   **/
}

class Listing extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.785,
      child: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(myProducts.length, (index) {
          // print("index" + "${index}");
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 148.0,
                  // child: Image.memory(base64.decode(base64ImageUrl)),
                  child: FlatButton(
                    child: Image.network(myProducts[index]['image']),
                    onLongPress: ()  {
                      //deleteornot(context, index);

                      myProducts.removeAt(index);

                      (context as Element).reassemble();

                    },
                  ),
              ),
            ],
          );
        }),
      ),
    );
  }
}