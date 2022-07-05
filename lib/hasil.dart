import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul1_old/login.dart';
import 'package:modul1_old/main.dart';
class Hasil extends StatelessWidget {
  const Hasil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
    if(snapshot.connectionState == ConnectionState.waiting){
    return Center(child: CircularProgressIndicator(),);
    }else if(snapshot.hasData){
      return MyApp();
    } else if(snapshot.hasError){
      return Center(child: Text("Has wrong"),);
    }else{
      return Login();
    }

        },
        ),
      );

  }
}
