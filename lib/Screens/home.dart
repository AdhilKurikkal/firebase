import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseui/Screens/datapass.dart';
import 'package:firebaseui/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(w * 0.03),
                        height: h * 0.1,
                        width: w * 0.35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(w * 0.05)),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data[index]['name']),
                              titleTextStyle: TextStyle(color: Colors.black),
                              subtitle: Text(data[index]['email']),
                              subtitleTextStyle: TextStyle(color: Colors.black),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DatapassPage(id: data[index].id),
                                    ));
                                // print(data[index].id);
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
