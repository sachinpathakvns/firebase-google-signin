import 'package:firebasedemo/provider/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class signin extends StatelessWidget {
  const signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          child: Image.asset("image/firebase.png"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
          ),
          height: 350,
        ),
        Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hi There,\nWelcome Back',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Login to your account to continue",
          style: TextStyle(fontSize: 16),
          ),
        ),
        Spacer(),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity,50),
          ),
          onPressed: (){
            final provider = Provider.of<GooglesignInProvider>(context,listen: false);
            provider.googleLogin();
          },
          icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
          label: Text('Sign Up with Google'),),
        SizedBox(height: 40,),
        RichText(text: TextSpan(
          text: 'Already have an account?',
          children: [
            TextSpan(text: 'Login',
            style: TextStyle(decoration: TextDecoration.underline)
            )
          ]
        ))
      ],
    ),

  );

}
