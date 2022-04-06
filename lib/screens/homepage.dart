// import 'package:fire_chat/main.dart';
// import 'package:fire_chat/methods/methods.dart';
// import 'package:fire_chat/screens/login_screen.dart';
// import 'package:fire_chat/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? userMap;

  void onSearch() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _fireStore
        .collection('users')
        .where("email", isEqualTo: _searchController.text)
        .get()
        .then((user) {
      setState(() {
        userMap = user.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('🔥 Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    height: size.height / 10,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 10,
                      width: size.width / 1.1,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 300,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlueAccent)),
                    onPressed: onSearch,
                    child: Text('Search'),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  userMap != null
                      ? ListTile(
                          onTap: () {},
                          title: Text(
                            userMap!['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(userMap!['email']),
                          leading: const Icon(
                            Icons.person,
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: size.height / 3,
                            ),
                            const Text('')
                          ],
                        )
                ],
              ),
            ),
    );
  }
}
