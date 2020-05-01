import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_app2/pages/home.dart';
import '../globals.dart';


final TextEditingController _phone = new TextEditingController();
class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String _smsVerificationCode;


  _verifyPhoneNumber(BuildContext context) async {
    phoneNumber = "+961" + _phone.text;
    print('phoneNumber : $phoneNumber');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 5),
        verificationCompleted: (authCredential) => _verificationComplete(authCredential, context),
        verificationFailed: (authException) => _verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
        // called when the SMS code is sent
        codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]));
  }
  _verificationComplete(AuthCredential authCredential, BuildContext context) {
    print('in _verificationComplete');
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
      final snackBar = SnackBar(content: Text("Success!!! UUID is: " + authResult.user.uid));
      Scaffold.of(context).showSnackBar(snackBar);

    });

//print (phoneNumber);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>Home())
    );
  }

  _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  _verificationFailed(AuthException authException, BuildContext context) {
    final snackBar = SnackBar(content: Text("Exception!! message:" + authException.message.toString()));
    Scaffold.of(context).showSnackBar(snackBar);

  }

  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;

  }
  // String phoneNo;
  // String smsCode;
  // String verificationId;

  // Future<void> verifyNumber() async{
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve=(String verID){
  //     this.verificationId=verID;
  //     ///Dialog here
  //     smsCodeDialog(context);
  //   };

  //   final PhoneVerificationCompleted verificationSuccess=(AuthCredential credential){
  //     print("Verified");
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
  //         Home()
  //     ));
  //   };

  //   final PhoneCodeSent smsCodeSent=(String verID,[int forceCodeResend]){
  //     this.verificationId=verID;
  //     Navigator.pop(context);
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
  //         Home()
  //     ));
  //   };

  //   final PhoneVerificationFailed verificationFailed=(AuthException exception){
  //     print('$exception.message');
  //   };

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: this.phoneNo,
  //       codeAutoRetrievalTimeout: autoRetrieve,
  //       codeSent: smsCodeSent,
  //       timeout: const Duration(seconds: 5),
  //       verificationCompleted: verificationSuccess,
  //       verificationFailed: verificationFailed

  //   );
  // }

  // Future<bool> smsCodeDialog(BuildContext context){
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context)=> AlertDialog(
  //         title: Text("Enter SMS code"),
  //         content: TextField(

  //             onChanged: (value){
  //               this.smsCode=value;
  //             }
  //         ),
  //         actions: <Widget>[
  //           RaisedButton(
  //             color: Colors.teal,
  //             child: Text("Done", style: TextStyle(color: Colors.white),),
  //             onPressed: (){
  //               FirebaseAuth.instance.currentUser().then((user){
  //                 if(user!=null){
  //                   Navigator.pop(context);
  //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
  //                       Home()

  //                   ));
  //                 }
  //                 else{
  //                   Navigator.pop(context);
  //                   signIn();
  //                 }
  //               });
  //             },
  //           ),
  //         ],
  //       )
  //   );
  // }

  // signIn()async{
  //   final AuthCredential credential= PhoneAuthProvider.getCredential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   await FirebaseAuth.instance.signInWithCredential(credential).then((user){
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
  //         Home()

  //     ));
  //   }).catchError((e)=>print(e));
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        centerTitle: true,
        title: Text("تسجيل الدخول"),
      ),
      body: ListView(children: <Widget>[
        TextField(
          decoration: InputDecoration(hintText: "ادخل رقم الهاتف"),
          controller: _phone,
          // onChanged: (value){
          //   _phone.text=value;
          // },
        ),
        RaisedButton(
          color: Colors.teal,
          // onPressed: ,
          onPressed: (){
            print('hello');
            _verifyPhoneNumber(context);
          },
          child: Text("Verify", style: TextStyle(color: Colors.white),),
        ),
        RaisedButton(
          child: Text("Next page"),
          onPressed: () {
            phoneNumber = _phone.text;
            print(phoneNumber);
            Navigator.pushNamed(context, '/home');
          },
        ),
      ],),
    );
  }
}