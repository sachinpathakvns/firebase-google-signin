import 'package:firebasedemo/chatexample.dart';
import 'package:flutter/material.dart';

class UserChatList extends StatefulWidget {

  @override
  State<UserChatList> createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {

  List<Map<String, String>> userData = [
    {'title': 'Nina Johnson', 'subtitle': 'Have you Checked my Pulse Rate??', 'from': 'sachin1', 'to': 'sachin2'},
    {'title': 'John Davis', 'subtitle': 'Hey Sir! I need your Help...','from': 'sachin4', 'to': 'sachin3'},
    {'title': 'Nina Johnson', 'subtitle': 'Have you Checked my Pulse Rate??','from': 'sachin6', 'to': 'sachin5'},
    {'title': 'Nina Johnson', 'subtitle': 'Have you Checked my Pulse Rate??','from': 'sachin8', 'to': 'sachin7'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 60,right:20,bottom: 30),
            child: Row(
              children: [
                CircleAvatar(
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
                const SizedBox(width: 32,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children to the start and end
                  children: [
                    Text(
                      'CHAT',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left:8),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 18),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/11/19/09/45/man-1838330_640.jpg'),
                  ),
                  title: Text(
                    userData[index]['from']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userData[index]['subtitle']!),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatScreen(fromid: userData[index]['from'].toString(), to: userData[index]['to'].toString(),),));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}