import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflit_database/Models/Note.dart';
import 'package:sqflit_database/Repo/DatabaseHelper.dart';
import 'package:sqflit_database/Views/Home/Home.dart';
import 'package:sqflit_database/Views/Modify/Components/components.dart';

class Modify extends StatefulWidget {
  int id;
  String appBarTitle;
  String title;
  String desc;
  String date;
  int priority;

  Modify({this.appBarTitle, this.title, this.desc, this.date, this.priority, this.id});

  @override
  _ModifyState createState() => _ModifyState(
      appBarTitle: appBarTitle,
      id: id,
      title: title,
      desc: desc,
      date: date,
      priority: priority);
}

class _ModifyState extends State<Modify> {
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.initializeDatabase();
  }

  int id;
  String appBarTitle;
  String title;
  String desc;
  String date;
  int priority;

  _ModifyState(
      {this.appBarTitle, this.title, this.desc, this.date, this.priority, this.id});

  List<String> _priority = ["High", "Low"];
  var selectedPriority;
  int p = 2;

  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (title.isNotEmpty) {
      titleController.text = this.title;
      descController.text = this.desc;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(appBarTitle, style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: ()=> Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home())),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () async {
              if (title.isEmpty) {
                int result = await saveNote(
                    title: titleController.text,
                    desc: descController.text,
                    p: p);
                if (result != 0) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }
              }else if(title.isNotEmpty){
                int result = await updateNoteData(
                    title: titleController.text,
                    desc: descController.text,
                    p: p,
                    id: this.id);
                if (result != 0) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }
              }
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: Text(selectedPriority == null
                      ? "Select priority"
                      : selectedPriority),
                  items: [
                    DropdownMenuItem(value: "High", child: Text("High")),
                    DropdownMenuItem(value: "Low", child: Text("Low")),
                  ],
                  onChanged: (newPriority) {
                    setState(() {
                      selectedPriority = newPriority;
                      p = convertPriority(selectedPriority);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      label: Text("Title"),
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descController,
                  
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: Text("Description"),
                    border: InputBorder.none,
                  ),
                  maxLines: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                appBarTitle == "Edit note"
                    ? RaisedButton(
                        onPressed: () async {
                          await db.deleteNote(this.id);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                        },
                        color: Colors.red,
                        child: Text("Delete"),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
