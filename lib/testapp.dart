import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDemo extends StatefulWidget {
  static FirebaseFirestore? firestoredb;
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  String username = "", chatmessage = "", status = "Messages";
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    firebaseInit();
  }

  void firebaseInit() {
    try {
      //Firebase.initializeApp().whenComplete(() {

      // print("Initialized");
      // });
      FirebaseDemo.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

  //*****************************************************************************
  void deleteMessages(String name) async {
    dynamic result =
    await FirebaseDemo.firestoredb?.collection("messages").get();
    QuerySnapshot messages = result;
    print(messages);
    firebasedata = "";
    for (var message in messages.docs) {
      print(message.data());

      firebasedata = firebasedata + message.data().toString() + "\n";
      print(message.get("chatmessage"));
      print(message.get("messagefrom"));
      String msgfrom = message.get("messagefrom").toString();
      if (msgfrom == name)
        FirebaseDemo.firestoredb
            ?.collection("messages")
            .doc(message.id)
            .delete();
    }
    print(firebasedata);
    setState(() {});
  }

  //*****************************************************************************

  //*****************************************************************************
  void getMessages() async {
    dynamic result =
    await FirebaseDemo.firestoredb?.collection("messages").get();
    QuerySnapshot messages = result;
    print(messages);
    firebasedata = "";
    for (var message in messages.docs) {
      print(message.data());

      firebasedata = firebasedata + message.data().toString() + "\n";
      print(message.get("chatmessage"));
      print(message.get("messagefrom"));
    }
    print(firebasedata);
    setState(() {});
  }

  //*****************************************************************************

  //*****************************************************************************

  void getMessagesStream() async {
    print("Streams");

    dynamic result =
    await FirebaseDemo.firestoredb?.collection("messages").snapshots();
    print(result.runtimeType);
    Stream<QuerySnapshot> ms = result;
    setState(() {});
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        print(value.data());

        //await element.docs.removeAt(index);
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(value.get("chatmessage"));
        print(value.get("messagefrom"));
      }
    });
    print(firebasedata);
  }

  String loginfo = "Varanasi Software Junction";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          title: Text(loginfo),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseDemo.firestoredb
                    ?.collection("messages")
                //.collection("messages").where("messagefrom", isEqualTo: "champak")
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      final messages = snapshot.data?.docs;
                      List<Widget> lst = [];
                      for (var message in messages!) {
                        final messagetext = message.get("chatmessage");
                        final sender = message.get("messagefrom");
                        final messagetextfield = VsjTwo(
                          messagetext.toString(),
                          sender.toString(),
                        );
                        lst.add(messagetextfield);
                        lst.add(const SizedBox(
                          height: 10,
                        ));
                      }
                      return Column(
                        children: lst,
                      );
                    } else {
                      List<Text> lst = [];
                      lst.add(const Text("Waiting"));
                      return Column(
                        children: lst,
                      );
                    }
                  } catch (e) {
                    List<Text> lst = [];
                    lst.add(Text("Error" + e.toString()));
                    return Column(
                      children: lst,
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: VsjTwo.myInputDecoration(),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    username = value;
                    print(username);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textcontroller,
                  textAlign: TextAlign.center,
                  decoration: VsjTwo.myInputDecoration(),
                  onChanged: (value) {
                    chatmessage = value;
                    print(chatmessage);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseDemo.firestoredb?.collection("messages").add({
                      "chatmessage": chatmessage,
                      "messagefrom": username,
                      "time": DateTime.now().millisecondsSinceEpoch,
                    });
                    textcontroller.clear();
                  },
                  child: const Text("Send")),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}


class VsjTwo extends StatelessWidget {
  String message="",sender="";
  VsjTwo(String message,String sender)
  {
    this.message=message;
    this.sender=sender;
  }
  static TextStyle myTextStyle()
  {
    return const TextStyle(color: Colors.white,backgroundColor: Colors.blue,fontSize: 20,);
  }
  static InputDecoration myInputDecoration() {
    return const InputDecoration(hintText: "Text Input", border: OutlineInputBorder());
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blueAccent,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child:
        Row(

          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message,style:myTextStyle(),),

          ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(" : ",style: TextStyle(backgroundColor: Colors.white),),
            )
            ,Text(sender,style:myTextStyle(),)],
        )
    )

    ;
  }
}