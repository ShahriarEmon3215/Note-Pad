import 'package:flutter/material.dart';
import 'package:sqflit_database/Views/Home/Components/BodyUiHome.dart';
import 'package:sqflit_database/Views/Modify/Modify.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Notes", style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Color.fromARGB(255, 251, 251, 251),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Modify(
                        appBarTitle: "Add note",
                        title: '',
                        desc: '',
                        date: '',
                        priority: 2,
                      )));
        },
        child: Icon(Icons.add, color: Colors.black,),
        
      ),
      
      body: BodyUi(),
    );
  }
}
