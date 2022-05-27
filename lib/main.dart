import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "xxxxxxxx",
      appId: "1:933519137096:web:903bc08fd3a1d03d927b7d",
      messagingSenderId: "933519137096",
      projectId: "finders-service",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection("contact_data").snapshots();

    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Welcome to Flutter'),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: dataStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  final List storeDocs = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    print(data);
                  }).toList();

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data.toString()),
                        subtitle: Text(data.toString()),
                      );
                    }).toList(),
                  );
                })));
  }
}
