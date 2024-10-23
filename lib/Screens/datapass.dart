import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DatapassPage extends StatefulWidget {
  // final String name;
  // final String email;
  final String id;
  const DatapassPage({super.key, required this.id});

  @override
  State<DatapassPage> createState() => _DatapassPageState();
}

class _DatapassPageState extends State<DatapassPage> {
  var datas = [];
  getData() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        // .where('email', isEqualTo: "adil1234@gmail.com")
        .get();
    print(query.docs);

    for (var docs in query.docs) {
      print(docs.data());
      datas.add(docs.data());
      setState(() {});
    }
    // datas = query.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: datas.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(datas[index]['name']),
                subtitle: Text(datas[index]['email']),
              );
            },
          ),

          Center(
            child: ElevatedButton(
              child: Text('Get'),
              onPressed: () {
                getData();
              },
            ),
          ),
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('users')
          //       .doc(widget.id)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     var data = snapshot.data;

          //     return Column(
          //       children: [
          //         CircleAvatar(
          //           radius: 50,
          //           backgroundImage: NetworkImage(
          //             data!['image'],
          //           ),
          //         ),
          //         Text(data!['name'])
          //       ],
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
