import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference books
  final _myBox = Hive.box('mybox');

  //run if first time opening EVER this app?
  void createInitialData() {
    //todo- add priority
    DateTime now = DateTime.now();
    toDoList = [
      [
        "Something I need to do", //title
        false, //completed
        now, //time created
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', //description
        'high', //priority
      ],
      [
        "Something I did", //title
        true, //completed
        now, //time created
        'description', //description
        'low', //priority
      ],
    ];
  }

  //load data from db
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update data in Hive db
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

  //search terms in title and description
  List search(String term) {
    return toDoList.where((task) {
      String title = task[0].toLowerCase();
      String description = task[3].toLowerCase();
      return title.contains(term.toLowerCase()) ||
          description.contains(term.toLowerCase());
    }).toList();
  }
}
