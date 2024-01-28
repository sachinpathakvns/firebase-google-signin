import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/firebase_options.dart';
import 'package:firebasedemo/provider/google_sign_in.dart';
import 'package:firebasedemo/userchatlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GooglesignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase Login',
          home:  UserChatList(),
        ),
      );
}

final CollectionReference timerCollection =
    FirebaseFirestore.instance.collection('timers');

Future<void> initializeTimer() async {
  await timerCollection.doc('timer').set({'isEnded': false});
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    createObject();
  }

  Future<void> createObject() async {
    final ParseObject testObject = ParseObject('TestObject')
      ..set<String>('name', 'Back4App')
      ..set<int>('score', 42);

    try {
      final ParseResponse apiResponse = await testObject.save();
      if (apiResponse.success) {
        print('Object created with objectId: ${testObject.objectId}');
      } else {
        print('Failed to create object: ${apiResponse.error?.message}');
      }
    } catch (e) {
      print('Error creating object: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back4App Example'),
      ),
      body: Center(
        child: Text('Check the console for object creation status.'),
      ),
    );
  }
}
