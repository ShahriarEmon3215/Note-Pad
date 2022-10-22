import 'package:flutter/material.dart';
import 'package:sqflit_database/Models/Note.dart';
import 'package:sqflit_database/Repo/DatabaseHelper.dart';
import 'package:sqflit_database/Views/Modify/Modify.dart';
import 'package:sqflite/sqflite.dart';

import '../Home.dart';

class BodyUi extends StatefulWidget {
  const BodyUi({
    Key key,
  }) : super(key: key);

  @override
  State<BodyUi> createState() => _BodyUiState();
}

class _BodyUiState extends State<BodyUi> {
  DatabaseHelper db = DatabaseHelper();
  List<Note> noteList = List<Note>();

  @override
  void initState() {
    super.initState();
    db.initializeDatabase();
  }

  // void _updateListData(){
  //   final Future<Database> databaseFuture =  db.initializeDatabase();
  //   databaseFuture.then((value){
  //     Future<List<Note>> noteListFuture = db.getNoteList();
  //     noteListFuture.then((value) {
  //       setState(() {
  //         this.noteList = value;
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return db.getNoteList() != null
        ? FutureBuilder(
            future: db.getNoteList(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 3.0,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Modify(
                                    appBarTitle: "Edit note",
                                    id: snapshot.data[index].id,
                                    title: snapshot.data[index].title,
                                    desc: snapshot.data[index].description,
                                    date: snapshot.data[index].date,
                                    priority: snapshot.data[index].priority,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 6.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].title.length > 55
                                          ? snapshot.data[index].title.substring(0, 55) + '...'
                                          : snapshot.data[index].title,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data[index].date,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await db.deleteNote(snapshot.data[index].id);
                                             setState(() {});
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )
        : Center(
            child: Text("No data found"),
          );
  }
}
