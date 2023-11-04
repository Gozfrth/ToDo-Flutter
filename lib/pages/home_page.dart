import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/search_bar.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();

  ToDoDataBase db = ToDoDataBase();
  List filteredList = [];
  bool prioritySorted = false;

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
    });

    super.initState();
  }

  String selectedPriority = 'high';

  void selectedPrioritySetter(String newValue) {
    setState(() {
      selectedPriority = newValue;
    });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    DateTime now = DateTime.now();
    setState(() {
      db.toDoList.add([
        _titleController.text,
        false,
        now,
        _descriptionController.text,
        selectedPriority,
      ]);
      _titleController.clear();
      _descriptionController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    filteredList = List.from(db.toDoList);
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
      filteredList.sort((a, b) => a[2].compareTo(b[2]));
    });
  }

  void prioritySort() {
    setState(() {
      filteredList =
          filteredList.where((element) => element[4] == "high").toList() +
              filteredList.where((element) => element[4] == "medium").toList() +
              filteredList.where((element) => element[4] == "low").toList();
    });
  }

  void onSearch(String searchTerm) {}

  void onSort() {
    if (prioritySorted == false) {
      prioritySort();
      prioritySorted = true;
    } else {
      dateSort();
      prioritySorted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff272727),
      appBar: AppBar(
        backgroundColor: const Color(0xff353535),
        title: const Center(
          child: Text(
            "TO DO",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: filteredList[index][0],
                  taskCompleted: filteredList[index][1],
                  taskTime: filteredList[index][2],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  description: filteredList[index][3],
                  priority: filteredList[index][4],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
