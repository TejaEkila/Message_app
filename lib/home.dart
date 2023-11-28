// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:easylazy/constant/const.dart';
//import 'package:easylazy/servies/auth_server.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imagePaths =
      List.generate(10, (index) => 'lib/images/img${index + 1}.png');

//method for signout
//   void signout() {
// //get auth servers
//     final authServce = Provider.of<AuthServer>(context, listen: false);
//     authServce.signOut();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('E A S Y L A Z Y'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.camera_alt_rounded),
          onPressed: () {},
        ),
        actions:const [
          //IconButton(onPressed: signout, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  color: const Color.fromARGB(255, 57, 88, 168),
                  elevation: 20,
                  child: ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(imagePaths[index]),
                    ),
                    title: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "${list.elementAt(index)['name']}"),
                        ],
                      ),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 174, 172, 172),
                          fontSize: 13,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "${list.elementAt(index)['sub']}"),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                ExpansionTile(
                  title: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(102, 103, 102, 1))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 201, 197, 255))),
                      fillColor: Color.fromARGB(26, 236, 186, 186),
                      filled: true,
                      hintText: 'typing....',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  trailing: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  // children: [],
                )
              ],
            );
          }),
    );
  }
}
