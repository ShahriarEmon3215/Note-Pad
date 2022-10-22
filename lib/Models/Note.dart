class Note {
  int id;
  String title;
  String description;
  String date;
  int priority;

  Note({this.id, this.title, this.description, this.date, this.priority});

  int get getID => id;
  String get getTitle => this.title;
  String get getDescription => this.description;
  String get getDate => this.date;
  int get getPriority => this.priority;

  set setId(int newID) {
    this.id = newID;
  }
 
  set setTitle(String newTitle) {
    this.title = newTitle;
  }

  set setDescription(String newDesc) {
    this.description = newDesc;
  }

  set setDate(String newDate) {
    this.date = newDate;
  }

  set setPriority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this.priority = newPriority;
    }
  }


  // Convert note object to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = this.id;
    }
    map['title'] = this.title;
    map['description'] = this.description;
    map['date'] = this.date;
    map['priority'] = this.priority;

    return map;
  }


  // Extract note object from map
  Note.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.date = map['date'];
    this.priority = map['priority'];
  }

}
