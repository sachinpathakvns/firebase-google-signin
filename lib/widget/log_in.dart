import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_in.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            final provider = Provider.of<GooglesignInProvider>(context,listen: false);
            provider.logout();
          }, child: Text('Log Out'))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("image/profile1.jpg"),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20,),
            Text("Profile",style: TextStyle(fontSize: 24) ),
            SizedBox(height: 10,),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
            SizedBox(height: 10),
            Text("Name -" + user.displayName!,
              style: TextStyle(fontSize: 24,color: Colors.white),
            ),
            SizedBox(height: 10,),
            Text("Email -" + user.email!,
              style: TextStyle(fontSize: 24,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
