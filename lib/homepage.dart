import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/widget/log_in.dart';
import 'package:firebasedemo/widget/sign_in.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=> Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }  else if(snapshot.hasData){
          return Login();
        }
          else if(snapshot.hasError){
         return Center(child: Text('Something went wrong',));
        } else {
          return Signin();
        }
      },
    ),
  );
}
