import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:todo/data/database.dart';
import 'package:todo/pages/graph_page.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/search_bar.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();
  final _myBox = Hive.box('mybox');
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();
  String sortType = "Date";

//new
  bool islight = false; // Track the current theme

  ThemeData lightTheme = ThemeData.light(); // Define your light theme
  ThemeData darkTheme = ThemeData.dark(); // Define your dark theme

  ToDoDataBase db = ToDoDataBase();
  List filteredList = [];
  bool prioritySorted = false;
  String selectedPriority = 'high';

  @override
  void initState() {
    //if this is first time ever opening, create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    setState(() {
      filteredList = List.from(db.toDoList);

      //sort date wise and such that completed tasks are always at the bottom
      dateSort();
    });

    super.initState();
  }

  //sets the priority based on what the user sets it to.
  void selectedPrioritySetter(String newValue) {
    setState(() {
      selectedPriority = newValue;
    });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      int ind = db.toDoList.indexWhere((element) =>
          element[0] == filteredList[index][0] &&
          element[2] == filteredList[index][2]);
      db.toDoList[ind][1] = !db.toDoList[ind][1];
      if (db.toDoList[ind][1]) {
        DateTime now = DateTime.now();
        int subDays = random.nextInt(7);
        db.toDoList[ind][5] = now.subtract(Duration(days: subDays));
      } else {
        db.toDoList[ind][5] = null;
      }
    });
    db.updateDataBase();
    filteredList = List.from(db.toDoList);
    dateSort();
  }

  //All data related functions
  void saveNewTask() {
    DateTime now = DateTime.now();
    setState(() {
      db.toDoList.add([
        _titleController.text,
        false,
        now,
        _descriptionController.text,
        selectedPriority,
        null,
      ]);
      _titleController.clear();
      _descriptionController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    filteredList = List.from(db.toDoList);
    dateSort();
  }

  void createNewTask() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(200),
        ),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DialogBox(
              titleController: _titleController,
              descriptionController: _descriptionController,
              selectedPriority: selectedPriority,
              selectedPrioritySetter: selectedPrioritySetter,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList
          .removeWhere((element) => element[2] == filteredList[index][2]);
      filteredList = List.from(db.toDoList);
    });
    db.updateDataBase();
  }

  void dateSort() {
    setState(() {
      filteredList = List.from(db.toDoList);
      filteredList.sort((a, b) {
        if (a[1] && !b[1]) {
          return 1; // Move a to the end if a[1] is true and b[1] is false
        } else if (!a[1] && b[1]) {
          return -1; // Move b to the end if b[1] is true and a[1] is false
        } else {
          return DateTime.parse(a[2].toString())
              .difference(DateTime.parse(b[2].toString()))
              .inMinutes;
        }
      });
    });
  }

  void prioritySort() {
    setState(() {
      List<List<dynamic>> trueList = [];
      List<List<dynamic>> falseList = [];

      for (var element in filteredList) {
        if (element[1]) {
          trueList.add(element);
        } else {
          falseList.add(element);
        }
      }

      trueList.sort((a, b) {
        return DateTime.parse(a[2].toString())
            .difference(DateTime.parse(b[2].toString()))
            .inMinutes;
      });

      falseList.sort((a, b) {
        int priorityComparison = _comparePriority(a[4], b[4]);
        if (priorityComparison != 0) {
          return priorityComparison;
        } else {
          return DateTime.parse(a[2].toString())
              .difference(DateTime.parse(b[2].toString()))
              .inMinutes;
        }
      });

      filteredList = falseList + trueList;
    });
  }

  int _comparePriority(String priorityA, String priorityB) {
    if (priorityA == "high") {
      return -1; // high priority should come first
    } else if (priorityA == "medium" && priorityB == "high") {
      return 1; // medium priority should come after high priority
    } else if (priorityA == "medium" && priorityB == "low") {
      return -1; // medium priority should come before low priority
    } else if (priorityA == "low") {
      return 1; // low priority should come last
    } else {
      return 0; // priorities are the same
    }
  }

  void onSearch(String searchTerm) {
    setState(() {
      filteredList = db.toDoList
          .where((element) =>
              element[0].toLowerCase().contains(searchTerm.toLowerCase()) ||
              element[3].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  void onSort() {
    if (prioritySorted == false) {
      //sorts based on priority
      prioritySort();
      prioritySorted = true;
      sortType = "Priority";
    } else {
      //sorts based on date
      dateSort();
      prioritySorted = false;
      sortType = "Date";
    }
  }

  //ACTUAL HOMEPAGE WIDGET
  @override
  Widget build(BuildContext context) {
    // =set the theme based in the islight cariable

    final theme = islight ? lightTheme : darkTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme, //Apply the selected theme
      home: Scaffold(
        //backgroundColor: const Color(0xff272727),
        appBar: AppBar(
          actions: <Widget>[
            Switch(
              value: islight,
              onChanged: (value) {
                //handle theme toggle
                setState(() {
                  islight = value;
                });
              },
            )
          ],
          //backgroundColor: const Color(0xff353535),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GraphPage(filteredList: filteredList),
                    ),
                  );
                },
                child: Icon(Icons.graphic_eq),
              ),
              Text(
                "TO DO",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(
            side: BorderSide(color: Color(0xffd9d9d9), width: 2.0),
          ),
          foregroundColor: const Color(0xffd9d9d9),
          backgroundColor: const Color(0xff272727),
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            SearchSort(
              onSearch: onSearch,
              searchController: _searchController,
              onSort: onSort,
              sortType: sortType,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    taskName: filteredList[index][0],
                    taskCompleted: filteredList[index][1],
                    taskTime: filteredList[index][2],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                    description: filteredList[index][3],
                    priority: filteredList[index][4],
                    dateCompleted: filteredList[index][5],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
