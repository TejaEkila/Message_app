

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easylazy/chat_page.dart';
import 'package:easylazy/servies/auth_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //method for signout
  void signout() {
//get auth servers
    final authServce = Provider.of<AuthServer>(context, listen: false);
    authServce.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text('E A S Y L A Z Y'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.camera_alt_rounded),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: signout, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: _buildUerList(
        
      ),

    );
  }
  //build a list of users except for the current logged in user

  Widget _buildUerList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading!!');
          }
          return ListView(
              children: snapshot.data!.docs
                  .map<Widget>((doc) => _buildUerListItem(doc))
                  .toList(),
                  );
        },
        );
  }
  //build individual user list items

  Widget _buildUerListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all user except current user

    if (_auth.currentUser!.email != data['email']) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              
              leading: const CircleAvatar(backgroundColor: Colors.white),
              tileColor:  const Color.fromRGBO(
                      133,
                      127,
                      247,
                      1,
                    ),
              title:  Text(data['email'],style: const TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                            receiverUserEmail: data['email'],
                            receiverUserID: data['uid'])));
              },
              trailing: IconButton(
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
            ),
            
          ),
          // const ExpansionTile(
          //         title: TextField(
          //           style: TextStyle(color: Colors.white),
          //           decoration: InputDecoration(
          //             enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: Color.fromRGBO(102, 103, 102, 1))),
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: Color.fromARGB(255, 201, 197, 255))),
          //             fillColor: Color.fromARGB(26, 236, 186, 186),
          //             filled: true,
          //             hintText: 'typing....',
          //             hintStyle: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //         trailing: Icon(
          //           Icons.send,
          //           color: Colors.white,
                    
          //         ),
                  
          //         // children: [],
          //       )
        ],
      );
      
    } else {
      return Container();
    }
  }
}
