import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/userchatmodel.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  String fromid = '';
  String to = '';
  ChatScreen({Key? key, required this.fromid,required this.to}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();

  List<UserChatModel> _messagelist = [];

  static String generateConversationId(String user1Id, String user2Id) {
    List<String> sortedUserIds = [user1Id, user2Id]..sort();
    return '${sortedUserIds[0]}_${sortedUserIds[1]}';
  }


  String conversationId = '';

  @override
  void initState() {
    conversationId = generateConversationId(widget.fromid, widget.to);
    super.initState();
  }


  void sendMessage() {
    FirebaseFirestore.instance.collection('textchatting').add({
      'conversationId': conversationId,
      'from': widget.fromid,
      'to': widget.to,
      'message': message.text,
      'timestamp': FieldValue.serverTimestamp(),
      'isread': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEEEEEE),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF1A9FB2),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/11/19/09/45/man-1838330_640.jpg'),
            ),
            SizedBox(width: 10,),
            Text(
              'Sachin Pathak',
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("textchatting")
                        .where("conversationId", isEqualTo: conversationId).orderBy('timestamp', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }

                      if (!snapshot.hasData) {
                        return const Text('Document does not exist.');
                      }

                      final messages = snapshot.data?.docs;
                      final datas = snapshot.data?.docs;
                      for (DocumentSnapshot document in datas!) {
                        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

                        if(data?['from'] == widget.fromid){
                          document.reference.update({'isread': true});
                        }
                      }

                      _messagelist.clear();
                      _messagelist = messages
                          ?.map((e) => UserChatModel.fromJson(e.data() as Map<String, dynamic>))
                          .toList() ?? [];

                        Set<String> conversationIds = Set<String>();

                        FirebaseFirestore.instance
                            .collection("textchatting")
                            .where("from", isEqualTo: 'sachin2')
                            .get()
                            .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
                          for (QueryDocumentSnapshot<Map<String, dynamic>> document in snapshot.docs) {
                            conversationIds.add(document.data()['conversationId'] as String);
                          }

                          print(conversationIds.toList());
                        });

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _messagelist.length,
                        itemBuilder: (context, index) {
                          final todo = _messagelist[index];
                          bool isMe = widget.fromid == todo.from;

                          // FirebaseFirestore.instance.collection('textchatting').where("conversationId", isEqualTo: conversationId).update({
                          //   'isread': true,
                          // });

                          String formattedTime = todo.timestamp?.toDate()?.toString().substring(11, 16)  ?? '';

                          return isMe
                              ? _greenMessage(
                              message: todo.message,
                              time: formattedTime)
                              : _blueMessage(
                              message: todo.message,
                              time: formattedTime);
                          },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFD9D9D9),
                    ),
                    child: TextField(
                      controller: message,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (message.text.isNotEmpty) {
                        sendMessage();
                        message.clear();
                      } else {
                        // print('Please enter a message');
                      }
                    },
                    child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(Icons.send)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _blueMessage({required String message, required String time}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                  color: Color(0xFF0C5C75),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                  )),
              child:
              // widget.message.type == Type.text
              //     ?
              //show text
              Text(
                message,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              )
            //     :
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(15),
            //   child: CachedNetworkImage(
            //     imageUrl: widget.message.msg,
            //     placeholder: (context, url) => const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: CircularProgressIndicator(strokeWidth: 2),
            //     ),
            //     errorWidget: (context, url, error) =>
            //     const Icon(Icons.image, size: 70),
            //   ),
            // ),
          ),
        ),

        //message time
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            time,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _greenMessage({required String message, required String time}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //message content        //message time
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            time,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),

        Flexible(
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                  color: Color(0xFF1A9FB2),
                  //making borders curved
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                  )),
              child:
              // widget.message.type == Type.text
              //     ?
              //show text
              Text(
                message,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              )
            //     :
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(15),
            //   child: CachedNetworkImage(
            //     imageUrl: widget.message.msg,
            //     placeholder: (context, url) => const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: CircularProgressIndicator(strokeWidth: 2),
            //     ),
            //     errorWidget: (context, url, error) =>
            //     const Icon(Icons.image, size: 70),
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}

