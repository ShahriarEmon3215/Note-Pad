import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflit_database/Models/Note.dart';
import 'package:sqflit_database/Repo/DatabaseHelper.dart';

Color getPriorityColor(int p) {
  switch (p) {
    case 1:
      return Colors.blue;
      break;
    case 2:
      return Colors.blue[300];
      break;
  }
}

int convertPriority(String p) {
  if (p == 'High') {
    return 1;
  } else if (p == 'Low') {
    return 2;
  }
}



  Future<int> saveNote({String title, desc, int p}) async {
  String date = DateFormat.yMMMd().format(DateTime.now());

  Note note = Note();
  note.setTitle = title;
  note.setDescription = desc;
  note.setDate = "Created on $date";
  note.priority = p;

  DatabaseHelper db =  DatabaseHelper();
  db.initializeDatabase();

  int result;
  result = await db.insertNote(note);


  if (result != 0) {
    print("--------- saved ------------");
    
  } else {
    print("---------- failed to save --------");
  }
  return result;
}


Future<int> updateNoteData({String title, desc, int p, id}) async {
  String date = DateFormat.yMMMd().format(DateTime.now());

  Note note = Note();
  note.setId = id;
  note.setTitle = title;
  note.setDescription = desc;
  note.setDate = "Updated on $date";
  note.priority = p;

  DatabaseHelper db = DatabaseHelper();
  db.initializeDatabase();

  int result = await db.updateNote(note);
  

  if (result != 0) {
    print("--------- updated ------------");
  } else {
    print("---------- failed to update --------");
  }
  return result;
}
