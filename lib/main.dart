import 'package:firebasedemo/homepage.dart';
import 'package:firebasedemo/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
    create: (context) =>GooglesignInProvider(),
     child: MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      theme: ThemeData.dark().copyWith(accentColor: Colors.indigo),
      home: const HomePage(),
    ),
  );
  }


