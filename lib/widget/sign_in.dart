import 'package:firebasedemo/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Container(
          child: Image.asset("image/firebase.png"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
          ),
          height: 350,
        ),
        const Spacer(),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hi There,\nWelcome Back',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Login to your account to continue",
          style: TextStyle(fontSize: 16),
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.white,
            minimumSize: const Size(double.infinity,50),
          ),
          onPressed: (){
            final provider = Provider.of<GooglesignInProvider>(context,listen: false);
            provider.googleLogin();
          },
          icon: const FaIcon(FontAwesomeIcons.google,color: Colors.red,),
          label: const Text('Sign Up with Google'),),
        const SizedBox(height: 40,),
        RichText(text: const TextSpan(
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
