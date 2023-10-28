
import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/persons.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseReference refPerson = FirebaseDatabase.instance.ref().child("persons");
  Future<void> personAdd() async {
    var data = HashMap<String,dynamic>();
    data["person_name"] = "Punka";
    data["person_age"] = 22;
    refPerson.push().set(data);
  }

  Future<void> personDelete()async {
    refPerson.child("-NhsH8govkXILK4Ktj71").remove();
  }
  Future<void> personUpdate () async{
    var data = HashMap<String,dynamic>();
    data["person_name"] = "Punhan";
    data["person_age"] = 22;
    refPerson.child("-NhsGSfH-x-nGqHeWN5F").update(data);
  }

  Future<void> getAllPerson () async{
    refPerson.onValue.listen((event) {
      var value = event.snapshot.value as dynamic;
      if(value !=null){
        value.forEach((key,object){
          var persons = Persons.fromJson(object);
          print("*************");
          print("Person key: $key");
          print("Person Name: ${persons.personName}");
          print("Person Age: ${persons.personAge}");
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    //personAdd();
    // personUpdate();
    // personDelete();
    //addDataToRealtimeDatabase();
    getAllPerson();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: const Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

          ],
        ),
      ),

    );
  }
}
